class ReservationsController < ApplicationController
  before_action :find_cookoon, :build_reservation

  def new
  end

  def create
    if @reservation.save
      flash[:notice] = 'Votre réservation a bien été prise en compte'
      redirect_to cookoons_path
    else
      flash[:alert] = 'Erreur'
      render :new
    end
  end

  private

  def find_cookoon
    @cookoon = Cookoon.find(params[:cookoon_id])
  end

  def build_reservation
    @reservation = current_user.reservations.build(reservation_params)
    build_prices
  end

  def build_prices
    @price_without_fee = Money.new(@reservation.duration * @cookoon.price)
    @cookoon_fee = Money.new(@price_without_fee * Reservation.cookoon_fee)
    @reservation.price = Money.new(@price_without_fee + @cookoon_fee)
  end

  def reservation_params
    params.require(:reservation).permit(:duration, :date, :price).merge(cookoon: @cookoon)
  end
end
