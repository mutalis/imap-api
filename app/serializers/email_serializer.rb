# EmailSerializer
class EmailSerializer < ApplicationSerializer
  attributes :id, :username, :quota, :domain_id, :edit_it

  def edit_it
    v2_email_url(object)
  end

  # def default_url_options
  #   { host: 'api.example.com' }
  # end
end
