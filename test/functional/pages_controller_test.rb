require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get spotlights" do
    get :spotlights
    assert_response :success
  end

  test "should get contests" do
    get :contests
    assert_response :success
  end

  test "should get faqs" do
    get :faqs
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

end
