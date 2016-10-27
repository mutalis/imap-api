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
  has_many :emails, inverse_of: :domain
end
