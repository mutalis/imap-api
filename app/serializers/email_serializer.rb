# EmailSerializer
class EmailSerializer < ApplicationSerializer
  attributes :id, :username, :quota, :domain_id

  # def default_url_options
  #   { host: 'api.example.com' }
  # end
end
