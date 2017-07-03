class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  layout "naked"

  def home
  end

  # To remove when more content added
  def member
  end
end
