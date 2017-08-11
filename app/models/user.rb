class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,:recoverable,
         :rememberable, :trackable, :validatable

  has_many :cookoons
  has_many :reservations
  has_many :reservations_requests, through: :cookoons, source: :reservations
  has_many :user_searches

  has_attachment :photo

  def full_name
    if first_name && last_name
      "#{first_name.capitalize} #{last_name.capitalize}"
    else
      "Utilisateur Cookoon"
    end
  end

  def stripe_account
    @stripe_account ||= StripeAccountService.new(user: self).retrieve_stripe_account
  end

  def stripe_verified?
    return false unless stripe_account
    stripe_account.payouts_enabled
  end
end
