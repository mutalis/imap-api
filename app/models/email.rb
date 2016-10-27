# == Schema Information
#
# Table name: emails
#
#  id         :uuid             not null, primary key
#  username   :string
#  quota      :integer
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  domain_id  :uuid
#
class Email < ApplicationRecord
  # ActiveRecord::Base.include_root_in_json = true
  validates :username, :quota, :password, presence: true
  validates :password, length: { minimum: 6 }

  belongs_to :domain, inverse_of: :emails
end
