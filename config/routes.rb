Rails.application.routes.draw do
  namespace :v1 do
    resources :emails
  end
  namespace :v2 do
    resources :domains do
      resources :emails, shallow: true
    end
  end
end
