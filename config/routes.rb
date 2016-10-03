Rails.application.routes.draw do
  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "courses#index"

	resources :courses, only: [:new, :create, :show, :index, :edit, :update] do
    resources :posts, :only => [:index, :show, :create] do
      resources :photos, :only => [:index, :show, :create, :update, :delete]
    end

    member do
      namespace :link, module: nil do
        get 'ios' => "ios_link#show"
      end
    end
  end

	resources :users
	resources :comments

  namespace :api, module: nil do
    resources :courses, only: [:show]
  end
end