class CookoonsController < ApplicationController
  def index
    @cookoons = Cookoon.all
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
    params.require(:cookoon).permit(:name, :surface, :price, :address, :capacity)
  end
end
