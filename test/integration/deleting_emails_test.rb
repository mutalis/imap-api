require 'test_helper'

# DeletingEmailsTest
class DeletingEmailsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @email = Email.create!(username: 'lau', quota: 100, password: 'password')
  end

  test 'deletes existing email' do
    delete "/#{api_version}/emails/#{@email.id}"
    assert_equal 204, response.status
  end
end
