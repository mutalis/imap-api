# EmailSerializer
class EmailSerializer < ApplicationSerializer
  attributes :id, :username, :quota

  # def default_url_options
  #   { host: 'api.example.com' }
  # end
end
