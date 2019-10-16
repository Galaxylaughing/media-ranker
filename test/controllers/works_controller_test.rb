require "test_helper"

describe WorksController do
  describe "index" do
    it "can get the work index" do
      get works_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get a valid work" do
      get work_path(works(:october).id)
      
      must_respond_with :success
    end
    
    it "redirects to works index for an invalid work" do
      get work_path(-1)
      
      must_redirect_to works_path
      expect(flash[:error]).must_equal "Could not find media with id: -1"
    end
  end
  
  describe "new" do
    it "can get the new work page" do
      get new_work_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can add a new work to the database" do
      work_hash = {
        work: {
          category: "album",
          name: "Ziggy Stardust",
          creator: "David Bowie",
          description: "a science fiction album",
          published_date: "16 June 1972"
        }
      }
      
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1
      
      new_work = Work.find_by(name: work_hash[:work][:name])
      
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.name).must_equal work_hash[:work][:name]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.published_date).must_equal Date.parse(work_hash[:work][:published_date])
      
      expect(flash[:success]).must_equal "Album added successfully"
      must_redirect_to work_path(new_work.id)
    end
    
    it "flashes a fail message if work fails to save" do
      work_hash = {
        work: {
          category: "album"
        }
      }
      
      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"
      
      expect(flash[:failure]).must_equal "Media failed to save"
      # test render??
    end
  end
  
  describe "edit" do
    it "can get the edit page for a valid work" do
      get edit_work_path(works(:october).id)
      
      must_respond_with :success
    end
    
    it "redirects for an invalid work" do
      get edit_work_path(-1)
      
      expect(flash[:error]).must_equal "Could not find media with id: -1"
      must_redirect_to works_path
    end
  end
  
end
