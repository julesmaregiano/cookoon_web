class Host::ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update]

  def index
    @reservations = policy_scope([:host, Reservation])
    @cookoons = current_user.cookoons
  end

  def edit
  end

  def update
    status = params["accept"] ? :accepted : :refused
    merged_params = reservation_params.merge(status: status)

    if @reservation.update(merged_params)
      if @reservation.accepted?
        paiement_service = StripePaiementService.new(user: current_user, reservation: @reservation)
        if paiement_service.capture_tax_and_payout
          flash[:notice] = "Vous avez accepté la réservation"
        else
          flash[:alert] = paiement_service.displayable_errors
        end
      else
        flash[:notice] = "Vous avez refusé la réservation"
      end

      redirect_to host_reservations_path
    else
      flash[:alert] = 'Erreur'
      render :edit
    end
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
    authorize [:host, @reservation]
  end

  def reservation_params
    params.require(:reservation).permit(:cleaning, :janitor)
  end
end
