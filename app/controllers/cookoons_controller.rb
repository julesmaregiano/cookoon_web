class CookoonsController < ApplicationController
  def index
    @cookoons = Cookoon.all
  end

  def show
    @cookoon = Cookoon.find(params[:id])
  end
end
