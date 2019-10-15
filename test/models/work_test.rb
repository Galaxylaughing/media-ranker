require "test_helper"

describe Work do
  describe "relationships" do    
    it "can have multiple votes" do
      work = works(:october)
      
      expect(work.votes).must_include votes(:scalzi_october)
      expect(work.votes).must_include votes(:butler_october)
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
  
  describe "find_highest_voted" do
    it "finds the work with the most votes" do     
      highest_voted = Work.find_highest_voted()
      
      expect(highest_voted).must_equal works(:october)
    end
    
    it "returns nil if there are no votes" do
      Vote.all.each do |vote|
        vote.destroy
      end
      
      highest_voted = Work.find_highest_voted()
      
      expect(highest_voted).must_be_nil
    end
  end
  
  describe "find_top_ten" do
    it "can find the top ten works" do
      # nine have two votes
      # one has three votes
      # one has one vote
      response = Work.find_top_ten("book")
      
      # should have ten items
      expect(response.length).must_equal 10
      # the first should be the book with 3 votes
      expect(response.first).must_equal works(:silver)
      # it should not include the book with 1 vote
      expect(response).wont_include works(:life_mccorkle)
    end
    
    it "returns an empty list if there are no works" do
      # remove all albums
      albums = Work.where(category: "album")
      albums.each do |album|
        album.destroy
      end
      
      response = Work.find_top_ten("album")
      
      expect(response).must_be_empty
    end
    
    it "returns a list even if there are no works" do
      response = Work.find_top_ten("album")
      
      expect(response.length).must_equal 10
    end
    
    it "returns a shorter list if there are fewer works" do
      movies = Work.where(category: "movie")
      movies.each do |movie|
        # keep one movie
        unless movie.name == "The Hunt for Red October"
          movie.destroy
        end
      end
      
      response = Work.find_top_ten("movie")
      
      expect(response.length).must_equal 1
    end
  end
end
