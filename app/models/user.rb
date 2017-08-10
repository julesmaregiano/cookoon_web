class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cookoons
  has_many :reservations
  has_many :reservations_requests, through: :cookoons, source: :reservations
  has_many :user_searches

  has_attachment :photo

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def stripe_account
    return nil unless stripe_account_id
    @stripe_account ||= Stripe::Account.retrieve(stripe_account_id)
  end

  def stripe_verified?
    return false unless stripe_account
    stripe_account.payouts_enabled
  end
end
