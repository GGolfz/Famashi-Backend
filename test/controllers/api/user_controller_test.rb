require "test_helper"

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_user_index_url
    assert_response :success
  end

  test "should get show" do
    get api_user_show_url
    assert_response :success
  end
end
