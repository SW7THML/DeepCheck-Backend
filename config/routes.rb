Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root "courses#index"

  resources :courses, only: [:new, :create, :show, :index, :edit, :update] do
    resources :posts, :only => [:index, :show, :create] do 
      resources :photos, :comments, :only => [:index, :show, :create, :update, :destroy]
    end
  end

  resources :users
  resources :comments

  namespace :api, module: nil do
    resources :courses, only: [:show]
  end

  get 'login' => 'login#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end