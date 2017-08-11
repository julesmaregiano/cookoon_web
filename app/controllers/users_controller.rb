class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Profil mis à jour"
      redirect_to root_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :photo, :description)
  end
end
