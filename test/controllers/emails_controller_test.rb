require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email = emails(:one)
  end

  test "should get index" do
    get emails_url, as: :json
    assert_response :success
  end

  test "should create email" do
    assert_difference('Email.count') do
      post emails_url, params: { email: { password: @email.password, quota: @email.quota, username: @email.username } }, as: :json
    end

    assert_response 201
  end

  test "should show email" do
    get email_url(@email), as: :json
    assert_response :success
  end

  test "should update email" do
    patch email_url(@email), params: { email: { password: @email.password, quota: @email.quota, username: @email.username } }, as: :json
    assert_response 200
  end

  test "should destroy email" do
    assert_difference('Email.count', -1) do
      delete email_url(@email), as: :json
    end

    assert_response 204
  end
end
