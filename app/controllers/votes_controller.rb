class VotesController < ApplicationController
  def upvote
    work_id = params[:work_id]
    work = Work.find_by(id: work_id)
    
    if work.nil?
      flash[:error] = "Work not found"
      redirect_back(fallback_location: works_path)
      return
    end
    
    user_id = session[:user_id]
    
    unless user_id
      flash[:error] = "You must log in to vote"
      redirect_back(fallback_location: works_path)
      return
    end
    
    existing_votes = Vote.find_by(user_id: user_id, work_id: work_id)
    if existing_votes
      flash[:error] = "Could not upvote"
      flash[:user] = "has already voted for this work"
      redirect_back(fallback_location: works_path)
      return
    end
    
    vote_hash = {
      work_id: work_id,
      user_id: user_id,
      date: Date.today
    }
    
    @vote = Vote.new(vote_hash)
    
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: works_path)
      return
    else
      flash[:failure] = "Could not upvote"
      redirect_back(fallback_location: works_path)
      return
    end
  end
end
