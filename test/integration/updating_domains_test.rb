require 'test_helper'

# UpdatingDomainsTest
class UpdatingDomainsTest < ActionDispatch::IntegrationTest
  setup do
    host! 'api.example.com'
    @domain = create(:domain)
    @user = create(:user)
  end

  test 'successful update' do
    patch "/#{api_version}/domains/#{@domain.id}",
          params: { domain: { name: 'new name' } }.to_json,
          headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                     'Content-Type': Mime[:json].to_s }

    assert_equal 200, response.status
    assert_equal 'new name', @domain.reload.name
  end

  test 'unsuccessful update on short name' do
    patch "/#{api_version}/domains/#{@domain.id}",
          params: { domain: { name: 'n' } }.to_json,
          headers: { Accept: Mime[:json], Authorization: token_header(@user.auth_token),
                     'Content-Type': Mime[:json].to_s }

    assert_equal 422, response.status
  end
end
