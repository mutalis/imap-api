# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  quota      :integer
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  domain_id  :integer
#
# Indexes
#
#  index_emails_on_domain_id  (domain_id)
#  index_emails_on_username   (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_728c164f32  (domain_id => domains.id) ON DELETE => cascade
#

# Email Model
class Email < ApplicationRecord
  # ActiveRecord::Base.include_root_in_json = true
  validates :username, :quota, :password, presence: true
  validates :password, length: { minimum: 8 }
  validates :username, uniqueness: { case_sensitive: true }

  belongs_to :domain, inverse_of: :emails

  default_scope { order(username: :asc) }
end
