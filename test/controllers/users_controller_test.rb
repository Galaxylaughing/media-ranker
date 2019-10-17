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
      expect(flash[:success]).must_equal "Successfully logged in as new user #{username}"
      
      must_redirect_to root_path
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
end
