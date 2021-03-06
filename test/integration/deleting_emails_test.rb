require 'test_helper'

# DeletingEmailsTest
class DeletingEmailsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @email = create(:email)
    @user = create(:user)
  end

  test 'deletes existing email' do
    delete "/#{api_version}/emails/#{@email.id}",
           headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 204, response.status
  end
end
