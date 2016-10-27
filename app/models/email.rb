# Email model
class Email < ApplicationRecord
  # ActiveRecord::Base.include_root_in_json = true
  validates :username, :quota, :password, presence: true
  validates :password, length: { minimum: 6 }

  belongs_to :domain, inverse_of: :emails
end
