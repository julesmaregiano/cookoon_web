module ReservationsHelper
  def display_datetime_for(reservation)
    reservation.date.strftime('%d/%m/%Y à %H:%M')
  end

  def display_duration_for(reservation)
    "#{reservation.duration} heures"
  end
end
