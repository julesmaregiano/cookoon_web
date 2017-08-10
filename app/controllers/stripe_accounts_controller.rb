require 'stripe_account_wrapper'

class StripeAccountsController < ApplicationController
  def new
  end

  def create
    account_wrapper = StripeAccountWrapper.new(params: params[:stripe], user: current_user, request_ip: request.remote_ip)
    # account = account_wrapper.retrieve_or_create_current_user_account
    byebug
    # account_wrapper.enrich(account)

    render :new
  end
end
