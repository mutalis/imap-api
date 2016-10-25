require 'test_helper'

# CreatingEmailsTest
class CreatingEmailsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'creates emails' do
    post "/#{api_version}/emails",
         params: { email: { username: 'ana', quota: 200, password: 'password' } }, as: :json,
         headers: { Accept: Mime[:json], 'Content-Type': Mime[:json].to_s }

    assert_equal 201, response.status
    assert_equal Mime[:json], response.content_type

    email = parse_j(response.body)
    # assert_equal v2_email_url(email[:id]), response.location
    assert_equal send("#{api_version}_email_url", email[:id]), response.location
  end

  test 'does not create emails with username, quota or password nil' do
    post "/#{api_version}/emails",
         params: { email: { username: nil, quota: nil, password: nil } }, as: :json,
         headers: { Accept: Mime[:json], 'Content-Type': Mime[:json].to_s }

    assert_equal 422, response.status
    assert_equal Mime[:json], response.content_type
  end
end
