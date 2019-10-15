require "test_helper"

describe User do
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
