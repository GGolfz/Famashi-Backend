require "test_helper"

class Api::AllergiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_allergies_index_url
    assert_response :success
  end

  test "should get create" do
    get api_allergies_create_url
    assert_response :success
  end

  test "should get update" do
    get api_allergies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_allergies_destroy_url
    assert_response :success
  end
end
