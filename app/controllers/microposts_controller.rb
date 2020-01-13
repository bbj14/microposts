class MicropostsController < ApplicationController
  before_action :required_user_logged_in
  before_action :set_correct_user, only: [:edit, :update, :destroy]

  def create
    @micropost = current_user.microposts.build(microposts_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end
  
  def update
    if @micropost.update(microposts_params)
      flash[:success] = "投稿を更新しました"
      redirect_to root_url
    else
      flash[:danger] = "投稿は更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @micropost.destroy!
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def microposts_params
    params.require(:micropost).permit(:content)
  end
  
  def set_correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end

end
