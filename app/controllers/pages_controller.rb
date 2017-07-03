class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  # To remove when more content added
  def member
  end
end
