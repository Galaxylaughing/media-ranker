require "test_helper"

describe Vote do
  describe "relationships" do    
    it "has a user" do
      vote = votes(:scalzi_october)
      expect(vote.user).must_equal users(:scalzi)
    end
    
    it "has a work" do
      vote = votes(:scalzi_october)
      expect(vote.work).must_equal works(:october)
    end
  end
  
  describe "validations" do
    before do
      user = users(:metz)
      work = works(:noteworthy)
      @vote = Vote.new(user_id: user.id, work_id: work.id)
    end
    
    it "can pass validations" do
      expect(@vote.valid?).must_equal true
    end
    
    it "is valid with a duplicate user but unique work" do
      new_work = works(:ophelia)
      new_vote = Vote.create(user_id: @vote.user_id, work_id: new_work.id)
      
      expect(@vote.valid?).must_equal true
    end
    
    it "is invalid without a user" do
      @vote.user_id = nil
      
      expect(@vote.valid?).must_equal false
    end
    
    it "is invalid without a work" do
      @vote.work_id = nil
      
      expect(@vote.valid?).must_equal false
    end
    
    it "is invalid without a unique work-user combination" do
      new_vote = Vote.create(user_id: @vote.user_id, work_id: @vote.work_id)
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user_id
    end
  end
  
  describe "delete matching votes for a work" do
    it "must change vote count" do
      work = works(:uglies)
      
      expect {
        Vote.delete_matching_work_votes(work)
      }.must_change "Vote.count", -2
    end
    
    it "must return a string of multiple votes" do
      work = works(:uglies)
      
      response = Vote.delete_matching_work_votes(work)
      expect(response).must_include "The votes for this work have been removed. The voters were"
    end
    
    it "must return a string of a single vote" do
      work = works(:life_mccorkle)
      
      response = Vote.delete_matching_work_votes(work)
      expect(response).must_include "The votes for this work have been removed. The voter was"
    end
  end
  
  describe "delete matching votes for a user" do
    it "must change vote count" do
      user = users(:metz)
      
      expect {
        Vote.delete_matching_user_votes(user)
      }.must_change "Vote.count", -1
    end
    
    it "must return a string of multiple votes" do
      user = users(:metz)
      
      response = Vote.delete_matching_user_votes(user)
      expect(response).must_include "The votes for this user have been removed. The works voted on were"
    end
    
    it "must return a string of a single vote" do
      user = users(:sabrina)
      
      response = Vote.delete_matching_user_votes(user)
      expect(response).must_include "The votes for this user have been removed. The work vote on was"
    end
  end
  
  describe "say vote/s" do
    it "says vote for one vote" do
      work = works(:life_mccorkle)
      votes = work.votes
      
      response = Vote.say_vote_s(votes.count)
      # this work has one vote
      expect(response).must_equal "vote"
    end
    
    it "says votes for zero or more than one vote" do
      work = works(:october)
      votes = work.votes
      
      response = Vote.say_vote_s(votes.count)
      # this work has four votes
      expect(response).must_equal "votes"
    end
  end
  
  describe "say vote" do
    it "returns vote" do
      response = Vote.say_vote
      expect(response).must_equal "vote"
    end
  end
  
  describe "say votes" do
    it "returns votes" do
      response = Vote.say_votes
      expect(response).must_equal "votes"
    end
  end
end
