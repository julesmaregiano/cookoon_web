class StripeAccountService
  attr_reader :params, :user, :request_ip, :errors, :account

  def initialize(attributes)
    @params = attributes[:params]
    @user = attributes[:user]
    @request_ip = attributes[:request_ip]
    @account = false
    check_params
  end

  def retrieve_or_create_user_account
    if user.stripe_account_id.nil?
      @account = create_stripe_account
      user.update(stripe_account_id: account.id) if account
    else
      @account = Stripe::Account.retrieve(user.stripe_account_id)
    end

    @account
  end

  def enrich_account
    return false unless account

    begin
      account.external_account = {
      	object: "bank_account",
      	account_holder_name: user.full_name,
      	currency: "eur",
      	country: "FR",
      	account_holder_type: "individual",
      	account_number: params[:iban]
      }

      account.legal_entity.address.city = params[:address][:city]
      account.legal_entity.address.line1 = params[:address][:street]
      account.legal_entity.address.postal_code = params[:address][:post_code]
      account.legal_entity.dob.day = params["dob(3i)"].to_i
      account.legal_entity.dob.month = params["dob(2i)"].to_i
      account.legal_entity.dob.year = params["dob(1i)"].to_i

      account.save
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Faild to enrich Stripe account")
      Rails.logger.error(e.message)
      @errors << e.message
      false
    end
  end

  def error_messages
    if errors.any?
      errors.join(", ")
    else
      "Une erreur est survenue avec notre partenaire de paiement veuillez retenter ultérieurement, pour des raisons de sécurité nous ne conservons pas vos données bancaires veuillez les saisir à nouveau."
    end
  end

  private

  def retrieve_stripe_account
    return false unless user
    begin
      Stripe::Account.retrieve(user.stripe_account_id)
    rescue Stripe::PermissionError => e
      Rails.logger.error("Failed to retrieve Stripe account")
      Rails.logger.error(e.message)
      @errors << e.message
      false
    end
  end

  def create_stripe_account
    begin
      Stripe::Account.create(
        type: 'custom',
        country: 'FR',
        email: user.email,
        legal_entity: {
          first_name: user.first_name,
          last_name: user.last_name,
          type: "individual"
        },
        tos_acceptance: {
          date: DateTime.now.to_i,
          ip: request_ip
        }
      )
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error("Faild to create Stripe account")
      Rails.logger.error(e.message)
      @errors << e.message
      false
    end
  end

  def check_params
    return false unless params

    @errors = []
    address_params = [params["address"]["city"], params["address"]["street"], params["address"]["post_code"]]
    if address_params.any? { |param| !param.present? }
      @errors << "Votre adresse est obligatoire"
    end

    dob_params = [params["dob(1i)"], params["dob(2i)"], params["dob(2i)"]]
    if dob_params.any? { |param| !param.present? }
      @errors << "Votre date de naissance est obligatoire"
    end

    if !params["iban"].present?
      @errors << "Votre IBAN est obligatoire"
    end
  end
end
