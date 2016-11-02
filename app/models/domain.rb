# == Schema Information
#
# Table name: domains
#
#  id         :uuid             not null, primary key
#  name       :string
#  quota      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Domain < ApplicationRecord
  validates :quota, presence: true
  validates :name, length: { minimum: 2 }

  has_many :emails, inverse_of: :domain

  default_scope { order(name: :asc) }
end
