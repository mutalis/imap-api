# Domain model
class Domain < ApplicationRecord
  has_many :emails, inverse_of: :domain
end
