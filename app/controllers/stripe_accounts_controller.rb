class StripeAccountsController < ApplicationController
  def new
  end

  def create
    account_service = StripeAccountService.new(params: params[:stripe], user: current_user, request_ip: request.remote_ip)

    account_service.retrieve_or_create_user_account unless account_service.errors.any?

    if account_service.enrich_account
      flash[:notice] = "Votre compte est maintenant lié avec Stripe. Vous pourrez prochainement récupérer vos paiements en attente"
      redirect_to edit_user_registration_path
    else
      flash[:alert] = account_service.error_messages
      redirect_to new_stripe_account_path
    end
  end
end
