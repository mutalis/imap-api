require 'test_helper'

# CreatingEmailsTest
class CreatingEmailsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @user = create(:user)
    @email = create(:email)
  end

  test 'creates emails' do
    post "/#{api_version}/emails",
         params: { email: { username: @email.username, quota: @email.quota, password: @email.password, domain_id: @email.domain_id } }, as: :json,
         headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                    'Content-Type': Mime[:json].to_s }

    assert_equal 201, response.status
    assert_equal Mime[:json], response.content_type

    email = parse_j(response.body)
    # assert_equal v2_email_url(email[:id]), response.location
    assert_equal send("#{api_version}_email_url", email[:id]), response.location
  end

  test 'does not create emails with username, quota or password nil' do
    post "/#{api_version}/emails",
         params: { email: { username: nil, quota: nil, password: nil, domain_id: nil } }, as: :json,
         headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                    'Content-Type': Mime[:json].to_s }

    assert_equal 422, response.status
    assert_equal Mime[:json], response.content_type
  end
end
