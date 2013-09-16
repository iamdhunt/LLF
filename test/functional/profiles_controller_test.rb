require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  
  test "should get show" do
    get :show, id: members(:dario).user_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should render a 404 on profile not found" do 
  	get :show, id: "doesn't exist"
  	assert_response :not_found
  end

  test "that variables are assigned on successful profile view" do 
  	get :show, id: members(:dario).user_name
  	assert assigns(:member)
  	assert_not_empty assigns(:statuses)
  end

  
  
end