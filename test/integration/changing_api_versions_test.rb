require 'test_helper'

# ChangingApiVersionsTest
class ChangingApiVersionsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test '/v1 returns version 1' do
    get '/v1/emails', headers: { Accept: Mime[:json] }
    assert_equal 200, response.status
    refute_empty response.body
  end

  test '/v2 returns version 2' do
    @user = User.create!
    get '/v2/emails',
        headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 200, response.status
    refute_empty response.body
  end
end
