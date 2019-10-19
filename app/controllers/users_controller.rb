class UsersController < ApplicationController
  before_action :get_user, only: [:show, :delete]
  
  def login_form
    user = User.new
  end
  
  def login
    username = params[:username]
    
    user = User.find_by(username: username)
    
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    elsif username.empty? || !!(username =~ /\A\s+\Z/)
      flash.now[:error] = "Username cannot be blank"
      render :login_form
      return
    else
      username = username.strip
      new_user = User.create(username: username, date_joined: Date.today)
      session[:user_id] = new_user.id
      flash[:success] = "Successfully logged in as new user '#{username}'"
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
    return
  end
  
  def index
    @users = User.sort_by_date_joined
  end
  
  def show; end
  
  def delete
    logged_in_id = logged_in?
    user = User.find_by(id: params[:id])
    
    if !logged_in_id || user.id != logged_in_id
      flash[:error] = "You are not authorized to perform this action"
      redirect_to root_path
      return
    end
  end
  
  def destroy
    logged_in_id = logged_in?
    user = User.find_by(id: params[:id])
    
    if logged_in_id && user.id == logged_in_id
      # vote deletion must come before user deletion
      # or the destroy action will cause an ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation
      # because the vote is still trying to link up to the user
      flash_notice = Vote.delete_matching_user_votes(user)
      if flash_notice
        flash[:votes] = flash_notice
      end
      
      if user.destroy
        # log out user
        session[:user_id] = nil
        flash[:success] = "#{user.username} deleted successfully"
        redirect_to root_path
        return
      else
        flash[:error] = "Something went wrong"
        redirect_to user_path(user.id)
        return
      end
    else
      flash[:error] = "You are not authorized to perform this action"
      redirect_to root_path
      return
    end
  end
  
  private
  
  def get_user
    @user = User.find_by(id: params[:id])
    
    if @user.nil?
      flash[:error] = "Could not find user with id: #{params[:id]}"
      redirect_to users_path
      return
    end
  end
  
  
  def logged_in?
    user_id = session[:user_id]
    
    if user_id.nil?
      return false
    end
    
    return user_id
  end
end
