require "test_helper"

describe Work do
  describe "relationships" do
    before do
      @user = User.create(username: "user")
      @work = Work.create(category: "book", name: "To Kill A Mockingbird", creator: "Harper Lee")
      @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    end
    
    it "can have a vote" do
      work = Work.find_by(name: @work.name)
      
      expect(work.votes).wont_be_nil
      expect(work.votes).must_include @vote
      expect(work.votes.count).must_equal 1
    end
    
    it "can have multiple votes" do
      new_user = User.create(username: "new user")
      new_vote = Vote.create(user_id: new_user.id, work_id: @work.id)
      
      work = Work.find_by(name: @work.name)
      
      expect(work.votes).wont_be_nil
      expect(work.votes).must_include new_vote
      expect(work.votes.count).must_equal 2
    end
  end
  
  describe "validations" do
    before do
      @work = Work.new(category: "book", name: "To Kill A Mockingbird", creator: "Harper Lee")
    end
    
    it "can pass validations" do
      expect(@work.valid?).must_equal true
    end
    
    it "is valid with a duplicate name but unique creator" do
      new_book = Work.create(category: "book", name: @work.name, creator: "Some Other Author")
      
      expect(@work.valid?).must_equal true
    end
    
    it "is invalid without a name" do
      @work.name = nil
      
      expect(@work.valid?).must_equal false
    end
    
    it "is invalid without a creator" do
      @work.creator = nil
      
      expect(@work.valid?).must_equal false
    end
    
    it "is invalid without a unique name-creator combination" do
      new_work = Work.create(category: "book", name: @work.name, creator: @work.creator)
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :name
    end
    
    it "is invalid without a category" do
      @work.category =  nil
      
      expect(@work.valid?).must_equal false
    end
  end
end
