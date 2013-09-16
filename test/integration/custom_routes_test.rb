require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  
  test "that /login route opens up the login page" do 
  	get '/login'
  	assert_response :success
  end 

  test "that /logout route opens up the login page" do 
  	get '/logout'
  	assert_response :redirect
  	assert_redirected_to '/'
  end 

  test "that /join route opens up the login page" do 
  	get '/join'
  	assert_response :success
  end 

  test "that a profile page works" do 
    get '/dhunt_4'
    assert_response :success
  end 

end
