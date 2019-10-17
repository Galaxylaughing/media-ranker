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
      flash.now[:failure] = "Media failed to save"
      render :new
      return
    end
  end
  
  def edit ; end
  
  def update
    if params.nil? || params[:work].nil? || params[:work].empty?
      flash[:failure] = "Invalid Media Attributes"
      render :edit
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.name.capitalize} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash[:failure] = "Media failed to save"
      render :edit
      return
    end
  end
  
  def destroy
    # vote deletion must come before work deletion
    # or the destroy action will cause an ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation
    # because the vote is still trying to link up to the work
    flash_notice = Vote.delete_matching_votes(@work)
    if flash_notice
      flash[:votes] = flash_notice
    end
    
    @work.destroy
    
    flash[:success] = "'#{@work.name}' deleted successfully"
    redirect_to works_path
    return
  end
  
  private
  
  def work_params
    if params[:work]
      return params.require(:work).permit(:category, :name, :creator, :published_date, :description)
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
  
end
