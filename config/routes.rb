Rails.application.routes.draw do
  constraints subdomain: 'api' do
    resources :emails
  end
end
