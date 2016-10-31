# DomainSerializer
class DomainSerializer < ApplicationSerializer
  attributes :id, :name, :quota
  has_many :emails
end
