require 'test_helper'

# DeletingDomainsTest
class DeletingDomainsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @domain = create(:domain)
    @user = create(:user)
  end

  test 'deletes existing domain' do
    delete "/#{api_version}/domains/#{@domain.id}",
           headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token) }
    assert_equal 204, response.status
  end
end
