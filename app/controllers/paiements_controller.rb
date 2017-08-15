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
          account: "acct_1An5DtFJfgkKkime",
        }
      })
    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      flash[:alert] = e.message
      new_reservation_paiement_path(@reservation)
    end

    if @reservation.update(status: :paid)
      flash[:notice] = "L'autorisation de paiement est effectuée vous serez débité seulement si le proprietaire accepte votre reservation"
      # TODO: Redirect sur une page de confirmation
      redirect_to reservations_path
    end
  end

  private

  def set_reservation
    @reservation = Reservation.where(status: :pending).find(params[:reservation_id])
  end
end
