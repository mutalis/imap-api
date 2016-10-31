require 'test_helper'

# ListingDomainsTest
class ListingDomainsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @user = create(:user)
  end

  test 'returns list of all domains' do
    domains = FactoryGirl.create_list(:domain, 2)
    # get '/domains', {}, Accept: Mime[:json]
    get "/#{api_version}/domains",
        headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 200, response.status
    refute_empty response.body
    domains_response = parse_j(response.body)
    names = domains_response.map { |z| z[:name] }
    assert_includes names, domains[0].name
    assert_includes names, domains[1].name
  end

  test 'returns domains in JSON' do
    get "/#{api_version}/domains",
        headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type
  end

  test 'returns domain by id' do
    domain = create(:domain)
    get "/#{api_version}/domains/#{domain.id}",
        headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 200, response.status

    domain_response = parse_j(response.body)
    assert_equal domain.name, domain_response[:name]
  end

  test 'valid authentication token' do
    get "/#{api_version}/domains",
        headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type
  end

  test 'invalid authentication' do
    get "/#{api_version}/domains",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token} fake" }
    assert_equal 401, response.status
    assert_equal Mime[:json], response.content_type
    assert_equal 'Token realm="Emails"', response.headers['WWW-Authenticate']
  end
end
