class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  
  def required_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def count(user)
    @count_microposts = user.microposts.count
  end
end
