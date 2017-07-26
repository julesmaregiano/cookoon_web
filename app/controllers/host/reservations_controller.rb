class Host::ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update]

  def index
    @reservations = current_user.reservations_requests
    @cookoons = current_user.cookoons
  end

  def edit
  end

  def update
    status = params["accept"] ? :accepted : :refused
    displayable_status = status == :accepted ? "accepté" : "refusé"
    merged_params = reservation_params.merge(status: status)
    if @reservation.update(merged_params)
      flash[:notice] = "Vous avez #{displayable_status} la réservation"
      redirect_to host_reservations_path
    else
      flash[:alert] = 'Erreur'
      render :edit
    end
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:cleaning, :janitor)
  end
end
