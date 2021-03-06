Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'main#index'
  get 'friendship' => 'main#friendship'
  get 'about' => 'main#about'
  get 'contacts' => 'main#contacts'

  devise_for :users, skip: [:registrations]
  devise_scope :user do
    get 'users/registration/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users/registration' => 'devise/registrations#update', as: 'user_registration'
  end

  get 'users/:id' => 'users#show', as: :user
  put 'users/:id' => 'users#update', as: :update_user

  resources :activities, module: :public_activity, only: [:index]

  mount Forem::Engine, at: '/forums'
  
  resources :candidates do
    get :approve, on: :member
  end

  get 'mailbox', to: redirect('/mailbox/inbox')
  get 'mailbox/inbox'
  get 'mailbox/sent'
  get 'mailbox/trash'

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  resources :orphanages
  resources :children

  resources :books do
    resources :comments
  end

  resources :albums

  resources :photos, only: [:show, :create, :destroy] do
    resources :comments
  end

  resources :meetings do
    member do
      get :reject
      get :reopen
    end
  end

  resources :reports do
    member do
      get :reject
      get :approve
    end
  end

end
