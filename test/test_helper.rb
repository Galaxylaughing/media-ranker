ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  def perform_login(user = nil)
    user ||= User.first
    
    login_data = {
      username: user.username,
    }
    post login_path, params: login_data
    
    # Verify the user ID was saved - if that didn't work, this test is invalid
    expect(session[:user_id]).must_equal user.id
    expect(flash[:success]).must_equal "Successfully logged in as returning user #{user.username}"
    
    must_redirect_to root_path
    
    return user
  end
  
  def perform_logout()
    # login
    current_user = perform_login()
    
    # logout
    post logout_path
    
    # assert
    expect(session[:user_id]).must_be_nil
    expect(flash[:success]).must_equal "Successfully logged out"
    
    must_redirect_to root_path
    
    return true
  end
end
