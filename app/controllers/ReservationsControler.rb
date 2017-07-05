class ReservationsController < ApplicationController
  def new
    # duration: 2, date: DateTime.now
    @Reservation = Reservation.new()
  end
end
