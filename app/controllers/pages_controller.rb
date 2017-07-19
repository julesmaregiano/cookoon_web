class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  layout "naked"

  def home
  end

  def dashboard
    
  end
end
