class Admin::UsersController < ApplicationController
  before_action :required_user_admin
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def toggle
    set_correct_user
    @user.update(user_params)
    #redirect_back(fallback_location: root_path)
  end
  
  private
  
  def required_user_admin
    unless current_user.admin
      redirect_to root_url
    end
  end

  def set_correct_user
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to root_url
    end
  end
  
  def user_params
    params.permit(:admin, :can_login, :can_post, :can_follow)
  end
end
