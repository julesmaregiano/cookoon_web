class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cookoons
  has_many :reservations

  has_attachment :photo

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
