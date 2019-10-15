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
  
end
