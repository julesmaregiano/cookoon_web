class Cookoon < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_attachments :photos, maximum: 5

  monetize :price_cents

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  CATEGORIES = %w(Appartement Maison Jardin Loft Terrasse Toit Villa)
end
