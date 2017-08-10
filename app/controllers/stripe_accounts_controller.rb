require 'stripe_account_wrapper'

class StripeAccountsController < ApplicationController
  def new
  end

  def create
    account_wrapper = StripeAccountWrapper.new(params: params[:stripe], user: current_user, request_ip: request.remote_ip)

    if account_wrapper.errors.any?
      flash[:alert] = account_wrapper.errors.join(", ")
      return redirect_to new_stripe_account_path
    end

    byebug

    account = account_wrapper.retrieve_or_create_user_account

    if account && account_wrapper.enrich(account)
      flash[:notice] = "Votre compte est maintenant lié avec Stripe. Vous pourrez prochainement récupérer vos paiements en attente"
      redirect_to edit_user_registration_path
    else
      flash[:alert] = "Une erreur est survenue avec notre partenaire de paiement veuillez retenter ultérieurement, pour des raisons de sécurité nous ne conservons pas vos données bancaires veuillez les saisir à nouveau."
      redirect_to new_stripe_account_path
    end
  end
end
