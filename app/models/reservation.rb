class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user

  monetize :price_cents

  validates :price_cents, presence: true

  def self.cookoon_fee
    0.07
  end
end
