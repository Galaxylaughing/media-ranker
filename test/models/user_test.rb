require "test_helper"

describe User do
  describe "relationships" do   
    it "can have multiple votes" do
      user = users(:scalzi)
      
      expect(user.votes).must_include votes(:scalzi_october)
      expect(user.votes).must_include votes(:scalzi_murderbot)
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
  
  describe "sort by date joined" do
    it "returns a list with the most recent users at the bottom" do     
      list = User.sort_by_date_joined
      
      # users(:metz) is the oldest user
      expect(list.first).must_equal users(:metz)
      
      # users(:butler) is the most recent user
      expect(list.last).must_equal users(:butler)
    end
    
    it "orders alphabetically by username if the date joined is the same" do
      list = User.sort_by_date_joined
      
      # "J" for "John Scalzi" comes before "S" for "Sabrina" in the alphabet
      expect(list[1]).must_equal users(:scalzi)
      expect(list[2]).must_equal users(:sabrina)
    end
  end
end
