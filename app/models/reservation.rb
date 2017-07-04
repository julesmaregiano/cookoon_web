class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user
end
