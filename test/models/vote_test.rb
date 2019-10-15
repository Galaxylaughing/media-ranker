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
end
