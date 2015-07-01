Rails.application.routes.draw do
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
  get 'items/:id/photos' => 'items#photos'

  
  resources :users
  resources :items, only: [:new, :create, :destroy, :edit] do
    member do
      get 'pictures'
      get 'location'
    end
  end
  scope :api do
  resources :picture, defaults: {format: 'json'}
end
  resources :picture
  resources :reservations
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :picture_contents, only: [:create]
end
