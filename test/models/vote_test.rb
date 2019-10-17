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
  
  describe "delete matching votes" do
    it "must change vote count" do
      work = works(:uglies)
      
      expect {
        Vote.delete_matching_votes(work)
      }.must_change "Vote.count", -2
    end
    
    it "must return a string of votes" do
      work = works(:uglies)
      
      response = Vote.delete_matching_votes(work)
      expect(response).must_include "The votes for this work have been removed"
    end
  end
end
