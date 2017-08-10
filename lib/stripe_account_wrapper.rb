require 'byebug'

class StripeAccountWrapper
  attr_reader :params, :user, :request_ip

  def initialize(attributes)
    @params = attributes[:params]
    @user = attributes[:user]
    @request_ip = attributes[:request_ip]
  end

  def retrieve_or_create_current_user_account
    if user.stripe_account_id.nil?
      # create stripe account via api
      account = Stripe::Account.create(
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

      user.update(stripe_account_id: account.id)
    else
      # retriever from api
      Stripe::Account.retrieve(user.stripe_account_id)
    end
  end

  def enrich(account)
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
    account.legal_entity.address.postal_code =  params[:address][:post_code]
    account.legal_entity.dob.day = params["dob(3i)"].to_i
    account.legal_entity.dob.month = params["dob(2i)"].to_i
    account.legal_entity.dob.year = params["dob(1i)"].to_i

    account.save
  end
end
