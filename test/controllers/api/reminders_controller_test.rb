require "test_helper"

class Api::RemindersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_reminders_index_url
    assert_response :success
  end

  test "should get update" do
    get api_reminders_update_url
    assert_response :success
  end
end
