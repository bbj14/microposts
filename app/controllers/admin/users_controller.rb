class Admin::UsersController < ApplicationController
  before_action :required_user_admin
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  private
  
  def required_user_admin
    unless current_user.admin
      redirect_to root_url
    end
  end
end
