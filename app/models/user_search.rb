class UserSearch < ApplicationRecord
  belongs_to :user

  scope :recents, -> { where("created_at > ?", 3.days.ago) }
end
