Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  resources :tags, only: :show
  resources :genres, except: :index

  delete 'charges/cancel_premium' => 'charges#cancel_premium', as: :cancel_premium
  get 'song_list' => 'welcome#song_list', as: :song_list

  resources :users, only: [] do
    resources :profiles, except: [:index, :destroy]
    resources :concerts, except: :index
    resources :songs, except: :show

    resources :profiles, only: [] do
      delete 'remove_avatar' => 'profiles#remove_avatar', as: :remove_avatar
    end
  end

  devise_for :users
  root 'welcome#index'
end
