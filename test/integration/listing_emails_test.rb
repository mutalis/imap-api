require 'test_helper'

# ListingEmailsTest
class ListingEmailsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'returns list of all emails' do
    Email.create!(username: 'lau', quota: 100, password: 'password')
    Email.create!(username: 'ana', quota: 200, password: 'password')

    # get '/emails', {}, Accept: Mime[:json]
    get '/emails', params: {}, headers: { Accept: Mime[:json] }
    assert_equal 200, response.status
    refute_empty response.body

    emails = parse_j(response.body)
    usernames = emails.map { |z| z[:username] }
    assert_includes usernames, 'lau'
    assert_includes usernames, 'ana'
  end

  test 'returns emails in JSON' do
    get '/emails', params: {}, headers: { Accept: Mime[:json] }
    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type
  end

  test 'returns email by id' do
    email = Email.create!(username: 'ana', quota: 200, password: 'password')
    get "/emails/#{email.id}"
    assert_equal 200, response.status

    email_response = parse_j(response.body)
    assert_equal email.username, email_response[:username]
  end
end
