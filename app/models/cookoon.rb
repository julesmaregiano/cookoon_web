class Cookoon < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_attachments :photos, maximum: 5

  monetize :price_cents
end
