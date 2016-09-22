Rails.application.routes.draw do
	# common
	devise_for :admins
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

	# for webview
	root "welcome#index"
	devise_for :users
	resources :courses do
    get "/join" => "courses#join", :on => :member
		resources :posts, :only => [:index, :create, :show, :update, :delete] do
			resources :photos, :only => [:index, :create, :update, :delete]
			resources :comments, :only => [:index, :create, :update, :delete]
		end
	end

	# for react-native
	namespace :api do
		authenticated :user do
			resources :courses, :only => [:index, :create, :show, :update, :delete] do
				post "/join" => "courses#join", :on => :member
				delete "/leave" => "courses#leave", :on => :member

				resources :posts, :only => [:index, :create, :show, :update, :delete] do
					resources :photos, :only => [:index, :create, :update, :delete] do
						post '/tag' => "photos#add_tag", :on => :member
						put '/tag/:tag_id' => "photos#edit_tag", :on => :member
						delete '/tag/:tag_id' => "photos#remove_tag", :on => :member
					end
					resources :comments, :only => [:index, :create, :update, :delete]
				end
			end
			resources :users
		end

		unauthenticated :user do
			resources :users, :only => [:create]
		end
	end
end
