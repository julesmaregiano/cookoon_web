class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :setcookies]
  layout "naked"

  def home
  end

  def setcookies
    lat_lng = "#{params[:lat]}|#{params[:lng]}"
    cookies[:lat_lng] ||= { value: lat_lng, expires: 5.hour.from_now }
  end
end
