require 'test_helper'

# EmailTest
class EmailTest < ActiveSupport::TestCase
  setup do
    @email = build(:email)
  end

  test 'valid email' do
    assert @email.valid?
  end
end
