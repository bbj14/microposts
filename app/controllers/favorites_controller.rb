class FavoritesController < ApplicationController
  before_action :required_user_logged_in
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
    #flash[:success] = '投稿をお気に入りに追加しました'
  end
  
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(@micropost)
    #flash[:success] = '投稿をお気に入りから削除しました'
  end
end
