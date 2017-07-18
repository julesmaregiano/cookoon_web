class UserSearchesController < ApplicationController
  def create
    @search = current_user.user_searches.build(search_params)
    @search.save
    redirect_to cookoons_path
  end

  private

  def search_params
    params.require(:user_search).permit(:address, :datetime, :number, :duration)
  end
end
