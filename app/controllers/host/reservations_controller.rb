class Host::ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update]

  def index
    @reservations = current_user.reservations_requests
    @cookoons = current_user.cookoons
  end

  def edit
  end

  def update
    byebug
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end
end
