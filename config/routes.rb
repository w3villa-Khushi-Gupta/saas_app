Rails.application.routes.draw do
  resources :tenants do
    resources :projects
  end
  root 'welcome#index'
  resources :members
  devise_for :users, controllers: { registrations: "registrations" }
end
