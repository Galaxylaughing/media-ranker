require "test_helper"

describe Work do
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
