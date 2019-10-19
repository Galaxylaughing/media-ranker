class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  # _should_ make sure all usr-work combinations must be unique
  # validates_uniqueness_of :user_id, scope: :work_id
  validates :user_id, presence: true, uniqueness: { scope: :work_id }
  validates :work_id, presence: true
  
  def self.delete_matching_user_votes(user)
    user_id = user.id
    matching_votes = Vote.where(user_id: user_id)
    matching_votes = delete_votes(matching_votes)
    
    if matching_votes
      works = []
      matching_votes.each do |vote|
        work = Work.find_by(id: vote.work_id)
        works << work.title
      end
      works_string = works.join(", ")
      flash_notice = "The votes for this user have been removed."
      if works.length == 1
        flash_notice << " The work vote on was #{works_string}"
      else
        flash_notice << " The works voted on were #{works_string}"
      end
    else
      return nil
    end
    return flash_notice
  end
  
  def self.delete_matching_work_votes(work)
    work_id = work.id
    matching_votes = Vote.where(work_id: work_id)
    matching_votes = delete_votes(matching_votes)
    
    if matching_votes
      voters = []
      matching_votes.each do |vote|
        user = User.find_by(id: vote.user_id)
        voters << user.username
      end
      votes_string = voters.join(", ")
      flash_notice = "The votes for this work have been removed."
      if voters.length == 1
        flash_notice << " The voter was #{votes_string}"
      else
        flash_notice << " The voters were #{votes_string}"
      end
    else
      return nil
    end
    return flash_notice
  end
  
  def self.delete_votes(matching_votes)
    if matching_votes.length > 0
      output = matching_votes
      matching_votes.each do |vote|
        vote.destroy
      end
      return output
    else
      return nil
    end
  end
  
  def self.say_vote_s(count)
    if count == 1
      response = Vote.say_vote
    else
      response = Vote.say_votes
    end
    return response
  end
  
  private
  
  def self.say_vote
    return "vote"
  end
  
  def self.say_votes
    return "votes"
  end
end
