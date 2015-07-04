Rails.application.routes.draw do
  get 'photos/new'

  get 'photos/create'

  get 'password_resets/new'

  get 'password_resets/edit'

  root                'static_pages#home'
  get 'help'    	=>	'static_pages#help'
  get 'about'   	=>	'static_pages#about'
  get 'contact' 	=> 	'static_pages#contact'
  get 'signup'	  =>	'users#new'
  get 'login'	    =>	'sessions#new'
  post 'login'	  =>	'sessions#create'
  delete 'logout'	=>	'sessions#destroy'

  get 'dashboard' => 'users#dashboard'
  get 'rack'      => 'items#index'
  get 'reservations' => 'reservations#show'
  get 'account'   => 'users#account'
  get 'rackit'    => 'items#new'
  post 'rackit'    => 'items#create'
  get 'items/:id/photos' => 'photos#show', as: :edit_photos

  
  resources :users
  resources :items, only: [:new, :create, :destroy, :edit] 
  resources :photos
  resources :reservations
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :picture_contents, only: [:create]
end
