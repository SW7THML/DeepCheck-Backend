Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  
	resources :courses, :only => [:index, :show, :update] do
    resources :posts, :only => [:index, :show, :create] do
      resources :photos, :only => [:index, :show, :create, :update]
    end
  end

	resources :users
	resources :comments
end
