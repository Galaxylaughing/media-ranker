class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  # _should_ make sure all usr-work combinations must be unique
  validates_uniqueness_of :user_id, scope: :work_id
  
  def self.delete_matching_votes(work)
    matching_votes = Vote.delete_votes(work)
    if matching_votes
      voters = []
      matching_votes.each do |vote|
        user = User.find_by(id: vote.user_id)
        voters << user.username
      end
      votes_string = voters.join(", ")
      flash_notice = "The votes for this work have been removed. The voters were #{votes_string}"
    else
      return nil
    end
    return flash_notice
  end
  
  def self.delete_votes(work)
    work_id = work.id
    
    matching_votes = Vote.where(work_id: work_id)
    
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
end
