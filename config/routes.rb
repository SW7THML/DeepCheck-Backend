Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root "courses#index"

	resources :courses, only: [:new, :create, :show, :index, :edit, :update] do
    get 'preview' => "courses#preview", :on => :member
    get 'join' => "courses#join", :on => :member
    resources :posts, :only => [:index, :show, :create] do
      resources :photos, :comments, :only => [:index, :show, :create, :update, :destroy]
    end

    member do
      namespace :link, module: nil do
        get 'ios' => "ios_link#show"
      end
    end
  end

  resources :photos, only: [] do
    resources :tags, only: [:index, :create, :update, :destroy]
  end

  resources :detail, only: [:show]
  resources :faces, only: [:destroy]

  resources :users

  namespace :api, module: nil do
    resources :courses, only: [:show]
  end

  get 'login' => 'login#show'
  get 'fetch' => 'sessions#fetch'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  put '/face/v1.0/persongroups/tester' => 'welcome#test'
end
