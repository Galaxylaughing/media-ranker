require "test_helper"

describe Vote do
  describe "relationships" do
    before do
      @user = User.create(username: "user", date_joined: Date.today)
      @work = Work.create(category: "book", name: "To Kill A Mockingbird", creator: "Harper Lee")
      @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    end
    
    it "has a user" do
      expect(@vote.user).wont_be_nil
      expect(@vote.user).must_equal @user
    end
    
    it "has a work" do
      expect(@vote.work).wont_be_nil
      expect(@vote.work).must_equal @work
    end
  end
end
