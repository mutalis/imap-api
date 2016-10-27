ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#minitest-rails

# Test helper
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include FactoryGirl::Syntax::Methods

  def parse_j(response_body)
    JSON.parse(response_body, symbolize_names: true)
  end

  def api_version
    'v2'
  end

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end
