require 'test_helper'

# CreatingDomainsTest
class CreatingDomainsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @user = create(:user)
    @domain = create(:domain_with_emails, emails_count: 1)
  end

  test 'creates domains' do
    post "/#{api_version}/domains",
         params: { domain: { name: @domain.name, quota: @domain.quota } }, as: :json,
         headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                    'Content-Type': Mime[:json].to_s }

    assert_equal 201, response.status
    assert_equal Mime[:json], response.content_type

    domain = parse_j(response.body)
    # assert_equal v2_domain_url(domain[:id]), response.location
    assert_equal send("#{api_version}_domain_url", domain[:id]), response.location
  end

  test 'does not create domains with name, quota or password nil' do
    post "/#{api_version}/domains",
         params: { domain: { name: nil, quota: nil } }, as: :json,
         headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                    'Content-Type': Mime[:json].to_s }

    assert_equal 422, response.status
    assert_equal Mime[:json], response.content_type
  end
end
