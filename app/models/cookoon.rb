class Cookoon < ApplicationRecord
  belongs_to :user
  monetize :price_cents
end
