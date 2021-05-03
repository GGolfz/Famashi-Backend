require "test_helper"

class Api::MedicinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_medicines_index_url
    assert_response :success
  end

  test "should get create" do
    get api_medicines_create_url
    assert_response :success
  end

  test "should get update" do
    get api_medicines_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_medicines_destroy_url
    assert_response :success
  end
end
