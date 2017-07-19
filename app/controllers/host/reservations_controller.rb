class Host::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations_requests
    @cookoons = current_user.cookoons
  end
end
