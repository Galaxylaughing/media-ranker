require "test_helper"

describe User do
  describe "relationships" do
    before do
      @user = User.create(username: "user", date_joined: Date.today)
      @work = Work.create(category: "book", name: "To Kill A Mockingbird", creator: "Harper Lee")
      @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    end
    
    it "can have a vote" do
      user = User.find_by(username: @user.username)
      
      expect(user.votes).wont_be_nil
      expect(user.votes).must_include @vote
      expect(user.votes.count).must_equal 1
    end
    
    it "can have multiple votes" do
      new_work = Work.create(category: "book", name: "Go Set A Watchman", creator: "Harper Lee")
      new_vote = Vote.create(user_id: @user.id, work_id: new_work.id)
      
      user = User.find_by(username: @user.username)
      
      expect(user.votes).wont_be_nil
      expect(user.votes).must_include new_vote
      expect(user.votes.count).must_equal 2
    end
  end
  
  describe "validations" do
    before do
      today = Date.today
      @user = User.new(username: "Fake User", date_joined: today)
    end
    
    it "can pass validations" do
      expect(@user.valid?).must_equal true
    end
    
    it "is invalid without a username" do
      @user.username = nil
      
      expect(@user.valid?).must_equal false
    end
    
    it "is invalid without a unique username" do
      tomorrow = Date.today + 1
      User.create(username: @user.username, date_joined: tomorrow)
      
      expect(@user.valid?).must_equal false
    end
    
    it "is invalid without a date joined" do
      @user.date_joined = nil
      
      expect(@user.valid?).must_equal false
    end
  end
end
