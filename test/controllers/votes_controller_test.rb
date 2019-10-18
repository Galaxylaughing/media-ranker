require "test_helper"

describe VotesController do
  describe "upvote" do
    it "can create a new vote" do
      # scalzi has not voted for this album
      work = works(:plastic)
      user = users(:scalzi)
      
      perform_login(user)
      
      expect {
        post work_upvote_path(work.id)
      }.must_change "Vote.count", 1
      
      new_vote = Vote.find_by(user_id: user.id, work_id: work.id)
      
      expect(new_vote.work_id).must_equal work.id
      expect(new_vote.user_id).must_equal user.id
      
      must_respond_with :redirect
      expect(flash[:success]).must_equal "Successfully upvoted!"
    end
    
    it "it will not create a duplicate vote" do
      # the vote scalzi_october already exists in in the test database
      work = votes(:scalzi_october).work
      user = votes(:scalzi_october).user
      
      perform_login(user)
      
      expect {
        post work_upvote_path(work.id)
      }.wont_change "Vote.count"
      
      votes = Vote.where(user_id: user.id, work_id: work.id)
      
      expect(votes.count).must_equal 1
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not upvote"
      expect(flash[:user]).must_equal "has already voted for this work"
    end
    
    it "will not upvote if there's no logged-in user" do
      # scalzi has not voted for this album
      work = works(:plastic)
      user = users(:scalzi)
      
      expect {
        post work_upvote_path(work.id)
      }.wont_change "Vote.count"
      
      votes = Vote.where(user_id: user.id, work_id: work.id)
      
      expect(votes.count).must_equal 0
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must log in to vote"
    end
    
    it "will give an error for a nonexistent work" do
      user = users(:metz)
      
      perform_login(user)
      
      expect {
        post work_upvote_path(-1)
      }.wont_change "Vote.count"
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Work not found"
    end
  end
end
