class StripePaiementService
  attr_reader :user, :token, :reservation, :customer, :charge

  def initialize(attributes)
    @user = attributes[:user]
    @token = attributes[:token]
    @reservation = attributes[:reservation]
    @errors = []
  end

  def create_charge_and_update_reservation
    retrieve_or_create_customer
    update_reservation if create_charge
  end

  def displayable_errors
    @errors.join(" ")
  end

  private

  def update_reservation
    reservation.update(status: :paid, stripe_charge_id: @charge.id)
  end

  def retrieve_or_create_customer
    if user.stripe_customer_id
      retrieve_customer
    else
      create_customer
    end
  end

  # le customer est créer avec sa carte
  # TODO: faire en sorte que le user puisse choisir parmi ses cartes sur le #new
  # sans avoir à saisir a nouveau.
  def create_customer
    @customer = Stripe::Customer.create(
      :description => "Customer for #{user.email}",
      :source => token
    )
    user.update(stripe_customer_id: customer.id)
    return @customer
  end

  def retrieve_customer
    @customer = Stripe::Customer.retrieve(user.stripe_customer_id)
  end

  def create_charge
    begin
      @charge = Stripe::Charge.create({
        amount: reservation.price_for_rent_with_fees.fractional,
        currency: 'eur',
        source: token,
        application_fee: reservation.cookoon_fees.fractional,
        description:  "Paiement pour #{reservation.cookoon.name}",
        capture: false,
        destination: {
          account: reservation.cookoon.user.stripe_account_id
        }
      })
    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      Rails.logger.error("Failed to create Stripe Charge")
      Rails.logger.error(e.message)
      @errors << e.message
      false
    end
  end
end
