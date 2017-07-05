class Reservation < ApplicationRecord
  belongs_to :cookoon
  belongs_to :user

  monetize :price_cents

  validates :price_cents, presence: true

  enum status: [ :pending, :accepted, :refused, :paid, :cancelled ]

  def price
    Money.new(price_without_fee + cookoon_fee)
  end

  def price_without_fee
    Money.new(duration * cookoon.price)
  end

  def cookoon_fee
    Money.new(price_without_fee * cookoon_fee_rate)
  end

  private

  def cookoon_fee_rate
    0.07
  end
end
