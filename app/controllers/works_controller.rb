class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :if_work_missing, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.sort_by_votes
  end
  
  def show ; end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    
    if @work.save
      flash[:success] = "#{@work.category.capitalize} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      render :new
      return
    end
  end
  
  def edit
    unless logged_in?(message: "make edits")
      redirect_to work_path(@work.id)
      return
    end
  end
  
  def update
    if logged_in?(message: "make edits")
      preupdate_category = @work.category
      
      if params.nil? || params[:work].nil? || params[:work].empty?
        flash.now[:failure] = "Invalid Media Attributes"
        render :edit
        return
      elsif @work.update(work_params)
        if @work.category != preupdate_category
          flash[:success] = "Successfully updated #{preupdate_category} with id #{@work.id}; now a #{@work.category}"
        else
          flash[:success] = "Successfully updated #{@work.category} with id #{@work.id}"
        end
        redirect_to work_path(@work.id)
        return
      else
        render :edit
        return
      end
    else
      redirect_to work_path(@work.id)
      return
    end
  end
  
  def destroy
    if logged_in?(message: "delete media entries")
      # vote deletion must come before work deletion
      # or the destroy action will cause an ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation
      # because the vote is still trying to link up to the work
      flash_notice = Vote.delete_matching_work_votes(@work)
      if flash_notice
        flash[:votes] = flash_notice
      end
      
      @work.destroy
      
      flash[:success] = "'#{@work.title}' deleted successfully"
      redirect_to works_path
      return
    else
      redirect_back(fallback_location: works_path)
      return
    end
  end
  
  private
  
  def work_params
    if params[:work]
      return params.require(:work).permit(:category, :title, :creator, :publication_date, :description)
    else
      return nil
    end
  end
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def if_work_missing
    if @work.nil?
      flash[:error] = "Could not find media with id: #{params[:id]}"
      redirect_to works_path
      return
    end
  end
  
  def logged_in?(message: "perform this action")
    user_id = session[:user_id]
    
    if user_id.nil?
      flash[:error] = "You must log in to #{message}"
      return false
    end
    
    return user_id
  end
  
end
