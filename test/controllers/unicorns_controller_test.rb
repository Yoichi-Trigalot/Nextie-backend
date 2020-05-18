require 'test_helper'

class UnicornsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unicorn = unicorns(:one)
  end

  test "should get index" do
    get unicorns_url, as: :json
    assert_response :success
  end

  test "should create unicorn" do
    assert_difference('Unicorn.count') do
      post unicorns_url, params: { unicorn: { color: @unicorn.color, sex: @unicorn.sex, type: @unicorn.type, user_id: @unicorn.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show unicorn" do
    get unicorn_url(@unicorn), as: :json
    assert_response :success
  end

  test "should update unicorn" do
    patch unicorn_url(@unicorn), params: { unicorn: { color: @unicorn.color, sex: @unicorn.sex, type: @unicorn.type, user_id: @unicorn.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy unicorn" do
    assert_difference('Unicorn.count', -1) do
      delete unicorn_url(@unicorn), as: :json
    end

    assert_response 204
  end
end
