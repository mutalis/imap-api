require 'test_helper'

# ChangingApiVersionsTest
class ChangingApiVersionsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test '/v1 returns version 1' do
    get '/v1/emails', params: {}, headers: { Accept: Mime[:json] }
    assert_equal 200, response.status
    refute_empty response.body
  end

  test '/v2 returns version 2' do
    get '/v2/emails', params: {}, headers: { Accept: Mime[:json] }
    assert_equal 200, response.status
    refute_empty response.body
  end
end
