require "test_helper"

class Api::MedicalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_medical_index_url
    assert_response :success
  end

  test "should get update" do
    get api_medical_update_url
    assert_response :success
  end
end
