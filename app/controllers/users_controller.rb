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
    elsif username.empty?
      flash[:error] = "Username cannot be blank"
      render :login_form
      return
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
      flash[:success] = "Successfully logged out"
    else
      flash[:error] = "No user logged in"
    end
    
    redirect_to root_path
  end
  
  def index
    @users = User.sort_by_date_joined
  end
  
  def show
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      flash[:error] = "Could not find user with id: #{params[:id]}"
      redirect_to users_path
      return
    end
  end
end
