require 'test_helper'

# UpdatingEmailsTest
class UpdatingEmailsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @email = Email.create!(username: 'lau', quota: 100, password: 'password')
  end

  test 'successful update' do
    patch "/emails/#{@email.id}",
          params: { email: { password: 'new password' } }.to_json,
          headers: { Accept: Mime[:json], 'Content-Type': Mime[:json].to_s }

    assert_equal 200, response.status
    assert_equal 'new password', @email.reload.password
  end

  test 'unsuccessful update on short password' do
    patch "/emails/#{@email.id}",
          params: { email: { password: 'short' } }.to_json,
          headers: { Accept: Mime[:json], 'Content-Type': Mime[:json].to_s }

    assert_equal 422, response.status
  end
end