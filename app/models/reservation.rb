class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user
  has_one :inventory

  monetize :price_cents

  validates :price_cents, presence: true

  enum status: [ :pending, :accepted, :refused, :paid, :cancelled, :ongoing, :passed ]

  def cookoon_fee_rate
    0.07
  end

  def pending_or_paid?
    pending? || paid?
  end
end
