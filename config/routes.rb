Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :v1 do
      resources :emails
    end
    namespace :v2 do
      resources :domains do
        resources :emails, shallow: true
      end
    end
  end
end
