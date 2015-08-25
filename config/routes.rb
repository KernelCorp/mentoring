Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'main#index'

  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  mount Forem::Engine, :at => '/forums'
  
  resources :candidates, only: [:new, :create]

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
  resources :books

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
