class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      flash[:error] = "Could not find media with id: #{work_id}"
      redirect_to works_path
      return
    end
  end
  
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
    end
  end
  
  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      flash[:error] = "Could not find media with id: #{work_id}"
      redirect_to works_path
      return
    end
  end
  
  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      flash[:error] = "Could not find media with id: #{work_id}"
      redirect_to works_path
      return
    elsif params.nil? || params[:work].nil? || params[:work].empty?
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
  
  private
  
  def work_params
    if params[:work]
      return params.require(:work).permit(:category, :name, :creator, :published_date, :description)
    else
      return nil
    end
  end
  
end
