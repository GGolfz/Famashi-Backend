require "test_helper"

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_user_index_url
    assert_response :success
  end

  test "should get update" do
    get api_user_update_url
    assert_response :success
  end

  test "should get password" do
    get api_user_password_url
    assert_response :success
  end

  test "should get image" do
    get api_user_image_url
    assert_response :success
  end
end
