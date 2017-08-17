class ReservationsController < ApplicationController
  before_action :find_cookoon, :build_reservation, only: [:create]

  def index
    @reservations = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation.price = @reservation.price_for_rent
    if @reservation.save
      flash[:notice] = 'Votre réservation a bien été prise en compte'
      #TODO: Go to payment
      redirect_to new_reservation_paiement_path(@reservation)
    else
      flash[:alert] = 'Erreur'
      redirect_to @cookoon
    end
  end

  private

  def find_cookoon
    @cookoon = Cookoon.find(params[:cookoon_id])
  end

  def build_reservation
    @reservation = current_user.reservations.build(reservation_params)
  end

  def reservation_params
    params.require(:reservation).permit(:duration, :date).merge(cookoon: @cookoon)
  end
end
