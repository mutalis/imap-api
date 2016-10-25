require 'test_helper'

# ListingEmailsTest
class ListingEmailsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @user = User.create!
  end

  test 'returns list of all emails' do
    Email.create!(username: 'lau', quota: 100, password: 'password')
    Email.create!(username: 'ana', quota: 200, password: 'password')

    # get '/emails', {}, Accept: Mime[:json]
    get "/#{api_version}/emails",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token}" }
    assert_equal 200, response.status
    refute_empty response.body

    emails = parse_j(response.body)
    usernames = emails.map { |z| z[:username] }
    assert_includes usernames, 'lau'
    assert_includes usernames, 'ana'
  end

  test 'returns emails in JSON' do
    get "/#{api_version}/emails",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token}" }
    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type
  end

  test 'returns email by id' do
    email = Email.create!(username: 'ana', quota: 200, password: 'password')
    get "/#{api_version}/emails/#{email.id}",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token}" }
    assert_equal 200, response.status

    email_response = parse_j(response.body)
    assert_equal email.username, email_response[:username]
  end

  test 'valid authentication token' do
    get "/#{api_version}/emails",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token}" }
    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type
  end

  test 'invalid authentication' do
    get "/#{api_version}/emails",
        headers: { Accept: Mime[:json], Authorization: :"Token token=#{@user.auth_token} fake" }
    assert_equal 401, response.status
    assert_equal Mime[:json], response.content_type
    assert_equal 'Token realm="Emails"', response.headers['WWW-Authenticate']
  end
end
