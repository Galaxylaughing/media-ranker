require "test_helper"

describe UsersController do  
  describe "login_form" do
    it "can get the login page" do
      get login_path
      
      must_respond_with :success
    end
  end
  
  describe "login" do
    it "logs in an existing user" do
      # tested in perform_login helper method
      current_user = perform_login()
      
      expect(current_user).wont_be_nil
    end
    
    it "creates a nonexisting user and logs them in" do
      username = "rubber_ducky"
      
      # arrange
      login_data = {
        username: username
      }
      
      # act
      post login_path, params: login_data
      
      user = User.find_by(username: username)
      
      # assert
      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_equal "Successfully logged in as new user '#{username}'"
      
      must_redirect_to root_path
    end
    
    it "strips leading and trailing whitespace" do
      # arrange
      login_data = {
        username: " apple "
      }
      
      # act
      post login_path, params: login_data
      
      user = User.find_by(username: "apple")
      
      # assert
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_equal "Successfully logged in as new user '#{user.username}'"
    end
    
    it "does not create an empty-string username" do
      # arrange
      login_data = {
        username: ""
      }
      
      # act
      post login_path, params: login_data
      
      user = User.find_by(username: "")
      
      # assert
      expect(user).must_be_nil
      expect(session[:user_id]).must_be_nil
      expect(flash[:error]).must_equal "Username cannot be blank"
    end
    
    it "does not create a whitespace username" do
      # arrange
      login_data = {
        username: " "
      }
      
      # act
      post login_path, params: login_data
      
      user = User.find_by(username: " ")
      
      # assert
      expect(user).must_be_nil
      expect(session[:user_id]).must_be_nil
      expect(flash[:error]).must_equal "Username cannot be blank"
    end
  end
  
  describe "current" do
    it "responds with success" do
      perform_login()
      
      get current_user_path
      
      must_respond_with :success
    end
    
    it "sets flash and redirects when no user" do
      get current_user_path
      
      must_redirect_to root_path
      expect(flash[:error]).must_equal "You must be logged in to see this page"
    end
  end
  
  describe "logout" do
    it "logs out the current user" do
      # tested in perform_logout helper method
      response = perform_logout
      
      expect(response).must_equal true
    end
    
    it "redirects if no current user" do
      post logout_path
      
      must_redirect_to root_path
      expect(flash[:error]).must_equal "No user logged in"
    end
  end
  
  describe "index" do
    it "can access the user index page" do
      get users_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get the page for an existing user" do
      user = users(:metz)
      
      get user_path(user.id)
      
      must_respond_with :success
    end
    
    it "redirects for an invalid user" do
      invalid_id = -1
      
      get user_path(invalid_id)
      
      expect(flash[:error]).must_equal "Could not find user with id: #{invalid_id}"
      must_redirect_to users_path
    end
  end
  
  describe "delete" do
    it "can get the delete account page for a logged in user" do
      user = users(:sabrina)
      
      perform_login(user)
      
      get delete_user_path(user.id)
      
      must_respond_with :success
    end
    
    it "can't access the delete account page for a logged out user" do
      user = users(:sabrina)
      
      get delete_user_path(user.id)
      
      expect(flash[:error]).must_equal "You are not authorized to perform this action"
      must_redirect_to root_path
    end
    
    it "can't access someone else's delete account page" do
      user_sabrina = users(:sabrina)
      user_metz = users(:metz)
      
      perform_login(user_sabrina)
      
      get delete_user_path(user_metz.id)
      
      expect(flash[:error]).must_equal "You are not authorized to perform this action"
      must_redirect_to root_path
    end
  end
  
  describe "destroy" do
    it "can delete a user and their votes" do
      user = users(:sabrina)
      votes = user.votes
      
      perform_login(user)
      
      expect {
        delete user_path(user.id)
      }.must_change "User.count", -1
      
      deleted_user = User.find_by(id: user.id)
      expect(deleted_user).must_be_nil
      
      expect(flash[:success]).must_equal "#{user.username} deleted successfully"
      
      votes.each do |vote|
        expect(vote).must_be_nil
      end
      
      # it should log out the user
      expect(session[:user_id]).must_be_nil
      must_redirect_to root_path
    end
    
    it "wont delete a user who is not logged in" do
      user = users(:sabrina)
      votes = user.votes
      
      expect {
        delete user_path(user.id)
      }.wont_change "User.count"
      
      undeleted_user = User.find_by(id: user.id)
      expect(undeleted_user).must_equal user
      
      expect(flash[:error]).must_equal "You are not authorized to perform this action"
      
      votes.each do |vote|
        expect(vote).wont_be_nil
      end
      
      must_redirect_to root_path
    end
    
    it "wont delete a different user" do
      user_sabrina = users(:sabrina)
      user_metz = users(:metz)
      
      perform_login(user_sabrina)
      
      expect {
        delete user_path(user_metz.id)
      }.wont_change "User.count"
      
      undeleted_user_1 = User.find_by(id: user_metz.id)
      expect(undeleted_user_1).must_equal user_metz
      
      undeleted_user_2 = User.find_by(id: user_sabrina.id)
      expect(undeleted_user_2).must_equal user_sabrina
      
      expect(flash[:error]).must_equal "You are not authorized to perform this action"
      
      must_redirect_to root_path
    end
  end
  
end
