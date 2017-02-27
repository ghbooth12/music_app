Rails.application.routes.draw do
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get 'mailbox/inbox', to: 'mailbox#inbox', as: :mailbox_inbox
  get 'mailbox/sent', to: 'mailbox#sent', as: :mailbox_sent
  get 'mailbox/trash', to: 'mailbox#trash', as: :mailbox_trash

  resources :charges, only: [:new, :create]
  resources :tags, only: :show
  resources :genres, except: :index

  delete 'charges/cancel_premium' => 'charges#cancel_premium', as: :cancel_premium
  get 'musicians' => 'welcome#musician_list', as: :musician_list
  get 'concerts' => 'welcome#concert_list', as: :concert_list

  resources :users, only: [] do
    resources :profiles, except: :destroy
    resources :concerts
    resources :songs, except: :show

    resources :profiles, only: [] do
      delete 'remove_avatar' => 'profiles#remove_avatar', as: :remove_avatar
    end
  end

  resources :profiles, only: [] do
    resources :favorites, only: [:create, :destroy]
  end

  resources :concerts, only: [] do
    resources :bookmarks, only: [:create, :destroy]
  end

  devise_for :users

  get 'auto_sign' => 'welcome#auto_sign'
  get 'demo_search' => 'welcome#demo_search'

  root 'welcome#index'
end
