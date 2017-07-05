class Cookoon < ApplicationRecord
  belongs_to :user
  has_many :reservations
  
  monetize :price_cents
end
