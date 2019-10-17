class UsersController < ApplicationController
  def login_form
    user = User.new
  end
  
  def login
    username = params[:username]
    
    user = User.find_by(username: username)
    
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      new_user = User.create(username: username, date_joined: Date.today)
      session[:user_id] = new_user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    
    redirect_to root_path
  end
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end
  
  def logout
    if session[:user_id]
      username = User.find_by(id: session[:user_id]).username
      
      session[:user_id] = nil
      flash[:success] = "user #{username} has successfully logged out"
    else
      flash[:error] = "No user logged in"
    end
    
    redirect_to root_path
  end
  
  def index
    @users = User.all
  end
end
