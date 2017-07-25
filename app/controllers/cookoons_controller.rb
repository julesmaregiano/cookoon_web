class CookoonsController < ApplicationController
  def index
    @new_search = UserSearch.new(number: 2, duration: 2, date: DateTime.now + 2.days)
    @last_search = current_search || @new_search
    @cookoons = Cookoon.near(@new_search.address || 'Paris', 10)
    prepare_infos
    build_markers
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
    @reservation = current_user.reservations.build(
      cookoon: @cookoon,
      date: current_search.try(:date) || DateTime.now + 2.days,
      duration: current_search.try(:duration) || 2,
    )
  end

  private

  def cookoon_params
    params.require(:cookoon).permit(:name, :surface, :price, :address, :capacity, :category, photos: [])
  end

  def prepare_infos
    @search_infos = {
      position: @last_search.address.try(:split, " - ").try(:first) || 'Autour de vous',
      time_slot: @last_search.date.try(:strftime, '%e %B %k:%M') || 'Tout de suite',
      people_number: @last_search.number || 4
    }
  end

  def build_markers
    @hash = Gmaps4rails.build_markers(@cookoons) do |cookoon, marker|
      marker.lat cookoon.latitude
      marker.lng cookoon.longitude
    end
  end
end
