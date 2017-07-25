class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user

  monetize :price_cents

  validates :price_cents, presence: true

  enum status: [ :pending, :accepted, :refused, :paid, :cancelled ]

  private

  def cookoon_fee_rate
    0.07
  end
end
