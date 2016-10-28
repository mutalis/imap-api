if Rails.env.development? || Rails.env.test?
  require 'factory_girl'

  namespace :dev do
    desc "Loads Factories (sample data) into the current environment's database"
    task(loads_factories: :environment) do
      include FactoryGirl::Syntax::Methods
      create_list(:domain_with_emails, 10).inspect
    end
  end
end
