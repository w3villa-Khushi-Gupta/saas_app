Rails.application.routes.draw do
  resources :artifacts
  resources :tenants do
    resources :projects
  end
  root 'welcome#index'
  resources :members
  devise_for :users, controllers: { registrations: "registrations" }
end
