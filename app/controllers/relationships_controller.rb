class RelationshipsController < ApplicationController
  before_action :required_user_logged_in
  before_action :required_user_follow, only: [:create]
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'ユーザをフォローしました'
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'ユーザのフォローを解除しました'
    redirect_to user
  end
  
  private
  
  def required_user_follow
    unless current_user.can_follow
      flash[:danger] = "follow restricted"
      redirect_back(fallback_location: root_path)
    end
  end
end
