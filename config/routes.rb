Rails.application.routes.draw do
	devise_for :users
	devise_scope :user do
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
			root "welcome#index"
			resources :users, :only => [:create]
		end
	end

	devise_for :admins
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
