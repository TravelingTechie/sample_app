class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    elsif user && !user.activated? && params[:admin] && params[:activate]
      user.activate
      flash[:success] = "Account activated!"
      redirect_to users_path 
    elsif user && user.activated? && params[:admin] && params[:deactivate]
      user.deactivate
      flash[:info] = "Account deactivated!"
      redirect_to users_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
