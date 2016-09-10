Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses, only: [] do

  	member do
      namespace :link, module: nil do
        get 'ios' => "ios_link#show"

      end
  	end
  end

  namespace :api, module: nil do
  	resources :courses, only: [:show]
  end
end