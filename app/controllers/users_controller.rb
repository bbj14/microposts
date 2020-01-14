class UsersController < ApplicationController
  before_action :required_user_logged_in, except: [:new, :create]
  before_action :set_correct_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    count(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to edit_user_path(@user)
    else
      flash[:danger] = "プロフィールは更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @user.destroy!
    #session[:user_id] = nil
    flash[:success] = "退会しました"
    redirect_to root_url
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
    count(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    count(@user)
  end
  
  def likes
    @favorites = @user.favorite_posts.page(params[:page])
    count(@user)
  end
  
  private
  
  def set_correct_user
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :biography, :image, :remove_image)
  end
end
