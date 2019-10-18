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
          title: "Ziggy Stardust",
          creator: "David Bowie",
          description: "a science fiction album",
          publication_date: "16 June 1972"
        }
      }
      
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1
      
      new_work = Work.find_by(title: work_hash[:work][:title])
      
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.publication_date).must_equal Date.parse(work_hash[:work][:publication_date])
      
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
      
      # test render??
    end
  end
  
  describe "edit" do
    it "can get the edit page for a valid work" do
      user = users(:metz)
      perform_login(user)
      
      get edit_work_path(works(:october).id)
      
      must_respond_with :success
    end
    
    it "redirects for an invalid work" do
      user = users(:metz)
      perform_login(user)
      
      get edit_work_path(-1)
      
      expect(flash[:error]).must_equal "Could not find media with id: -1"
      must_redirect_to works_path
    end
    
    it "wont show the edit page if the user isnt logged in" do
      work = works(:october)
      
      get edit_work_path(work.id)
      
      must_redirect_to work_path(work.id)
      expect(flash[:error]).must_equal "You must log in to make edits"
    end
  end
  
  describe "update" do
    it "can update an existing work with the same category" do
      work = works(:october)
      
      user = users(:metz)
      perform_login(user)
      
      work_hash = {
        work: {
          title: "Rubber Duck: Ducks Away",
          description: "the score from the movie"
        }
      }
      
      expect {
        patch work_path(work.id), params: work_hash
      }.wont_change "Work.count"
      
      updated_work = Work.find_by(id: work.id)
      
      expect(updated_work.title).must_equal work_hash[:work][:title]
      expect(updated_work.description).must_equal work_hash[:work][:description]
      
      # the unmodified fields should be the same
      expect(updated_work.category).must_equal work.category
      expect(updated_work.creator).must_equal work.creator
      expect(updated_work.publication_date).must_equal work.publication_date
      
      expect(flash[:success]).must_equal "Successfully updated #{work.category} with id #{work.id}"
      must_redirect_to work_path(updated_work.id)
    end
    
    it "can update an existing work with a new category" do
      work = works(:october)
      
      user = users(:metz)
      perform_login(user)
      
      work_hash = {
        work: {
          category: "album",
          description: "the score from the movie"
        }
      }
      
      expect {
        patch work_path(work.id), params: work_hash
      }.wont_change "Work.count"
      
      updated_work = Work.find_by(id: work.id)
      
      expect(updated_work.category).must_equal work_hash[:work][:category]
      expect(updated_work.description).must_equal work_hash[:work][:description]
      
      # the unmodified fields should be the same
      expect(updated_work.title).must_equal work.title
      expect(updated_work.creator).must_equal work.creator
      expect(updated_work.publication_date).must_equal work.publication_date
      
      expect(flash[:success]).must_equal "Successfully updated #{work.category} with id #{work.id}; now a #{updated_work.category}"
      must_redirect_to work_path(updated_work.id)
    end
    
    it "redirects for an invalid work path" do
      user = users(:metz)
      perform_login(user)
      
      patch work_path(-1)
      
      expect(flash[:error]).must_equal "Could not find media with id: -1"
      must_redirect_to works_path
    end
    
    it "wont update with invalid attributes" do
      work = works(:october)
      
      user = users(:metz)
      perform_login(user)
      
      work_hash = {
        work: {}
      }
      
      expect {
        patch work_path(work.id), params: work_hash
      }.wont_change "Work.count"
      
      # test render??
      
      unchanged_work = Work.find_by(id: work.id)
      expect(unchanged_work.category).must_equal work.category
      expect(unchanged_work.title).must_equal work.title
      expect(unchanged_work.creator).must_equal work.creator
      expect(unchanged_work.description).must_equal work.description
      expect(unchanged_work.publication_date).must_equal work.publication_date
    end
    
    it "wont update if the user is not logged in" do
      work = works(:october)
      
      work_hash = {
        work: {
          title: "Rubber Duck: Ducks Away",
          description: "the score from the movie"
        }
      }
      
      expect {
        patch work_path(work.id), params: work_hash
      }.wont_change "Work.count"
      
      updated_work = Work.find_by(id: work.id)
      
      expect(updated_work.title).must_equal work.title
      expect(updated_work.description).must_equal work.description
      
      # the hash fields should NOT have changed
      expect(updated_work.category).must_equal work.category
      expect(updated_work.creator).must_equal work.creator
      expect(updated_work.publication_date).must_equal work.publication_date
      
      expect(flash[:error]).must_equal "You must log in to make edits"
      must_redirect_to work_path(work.id)
    end
  end
  
  describe "destroy" do
    it "removes the work from the database" do
      work = works(:remember)
      
      user = users(:metz)
      perform_login(user)
      
      expect {
        delete work_path(work.id)
      }.must_change "Work.count", -1
      
      deleted_work = Work.find_by(id: work.id)
      expect(deleted_work).must_be_nil
      expect(flash[:success]).must_equal "'A Night to Remember' deleted successfully"
      
      must_redirect_to works_path
    end
    
    it "deletes any associated votes" do
      work = works(:indigo)
      
      user = users(:metz)
      perform_login(user)
      
      expect {
        delete work_path(work.id)
      }.must_change "Work.count", -1
      
      deleted_work = Work.find_by(id: work.id)
      expect(deleted_work).must_be_nil
      expect(flash[:votes]).must_include "The votes for this work have been removed"
      
      must_redirect_to works_path
    end
    
    it "redirects when the work is not found" do
      user = users(:metz)
      perform_login(user)
      
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"
      
      expect(flash[:error]).must_equal "Could not find media with id: -1"
      must_redirect_to works_path
    end
    
    it "does not delete if user is not logged in" do
      work = works(:remember)
      
      expect {
        delete work_path(work.id)
      }.wont_change "Work.count"
      
      undeleted_work = Work.find_by(id: work.id)
      expect(undeleted_work).must_equal work
      expect(undeleted_work.votes.count).must_equal work.votes.count
      
      expect(flash[:error]).must_equal "You must log in to delete media entries"
      must_respond_with :redirect
    end
    
    it "does not delete associated votes if user is not logged in" do
      work = works(:indigo)
      
      expect {
        delete work_path(work.id)
      }.wont_change "Work.count"
      
      undeleted_work = Work.find_by(id: work.id)
      expect(undeleted_work).must_equal work
      expect(undeleted_work.votes).must_equal work.votes
      expect(flash[:error]).must_equal "You must log in to delete media entries"
      
      must_respond_with :redirect
    end
  end
  
end
