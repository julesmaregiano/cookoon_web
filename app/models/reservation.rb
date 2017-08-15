class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user
  has_one :inventory

  monetize :price_cents

  validates :price_cents, presence: true

  enum status: [ :pending, :accepted, :refused, :paid, :cancelled, :ongoing, :passed ]

  def host_cookoon_fee_rate
    0.07
  end

  def rent_cookoon_fee_rate
    0.05
  end

  def pending_or_paid?
    pending? || paid?
  end

  def price_for_rent
    duration * cookoon.price
  end

  def cookoon_fees
    price_for_rent * rent_cookoon_fee_rate
  end

  def price_for_rent_with_fees
    price_for_rent + cookoon_fees
  end
end
