Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

	resources :photos, :only => [:index, :create]
	resources :courses, :only => [:index]
	resources :users
	resources :comments
end
