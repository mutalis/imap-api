require 'test_helper'

# RoutesTest
class RoutesTest < ActionDispatch::IntegrationTest
  test 'routes version' do
    assert_generates '/v1/emails', controller: 'v1/emails', action: 'index'
    assert_generates '/v2/emails', controller: 'v2/emails', action: 'index'
  end
end
