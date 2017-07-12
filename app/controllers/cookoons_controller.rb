class CookoonsController < ApplicationController
  def index
    @cookoons = Cookoon.all
    @hash = Gmaps4rails.build_markers(@cookoons) do |cookoon, marker|
      marker.lat cookoon.latitude
      marker.lng cookoon.longitude
    end
  end

  def new
    @cookoon = Cookoon.new
  end

  def create
    @cookoon = Cookoon.new(cookoon_params)
    @cookoon.user = current_user
    if @cookoon.save
      redirect_to @cookoon
    else
      render :new
    end
  end

  def show
    @cookoon = Cookoon.find(params[:id])
  end

  private

  def cookoon_params
    params.require(:cookoon).permit(:name, :surface, :price, :address, :capacity, :category, photos: [])
  end
end
