class PaiementsController < ApplicationController
  before_action :set_reservation

  def new
  end

  def create
    # TODO Faire en sorte que la reservation ne soit pas updater si le paiement ne passe pas
    begin
      charge = Stripe::Charge.create({
        amount: @reservation.price_cents,
        currency: @reservation.price.currency,
        source: params[:stripeToken],
        description:  "Paiement pour #{@reservation.cookoon.name}",
        application_fee: (@reservation.price_cents * @reservation.host_cookoon_fee_rate).floor,
        transfer_group: "RESA##{@reservation.id}",
        destination: {
          account: @reservation.cookoon.user.stripe_account_id,
        }
      })
    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      flash[:alert] = e.message
      return redirect_to new_reservation_paiement_path(@reservation)
    end

    @reservation.update(status: :paid)
    redirect_to @reservation, flash: { paiement_succeed: true }
  end

  private

  def set_reservation
    @reservation = Reservation.where(status: :pending).find(params[:reservation_id])
  end
end
