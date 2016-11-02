require 'test_helper'

# DomainTest
class DomainTest < ActiveSupport::TestCase
  setup do
    @domain = create(:domain_with_emails, emails_count: 5)
    # @domains = create_list(:domain,3)
  end

  test 'valid domain' do
    assert @domain.valid?
  end

  test 'emails relationship' do
    assert_equal 5, @domain.emails.size
  end

  test 'invalid without name' do
    domain = build(:domain)
    domain.name = nil
    refute domain.valid?, 'saved domain without a name'
    puts domain.errors[:name].inspect
    refute_empty domain.errors[:name], 'no validation error for name present'
  end
end
