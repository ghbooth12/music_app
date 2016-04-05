Rails.application.routes.draw do
  get 'song_list' => 'welcome#song_list', as: :song_list

  resources :users, only: [] do
    resources :profiles, except: [:index, :destroy]
    resources :concerts, except: :index

    delete 'profiles/remove_avatar' => 'profiles#remove_avatar', as: :remove_avatar
  end

  devise_for :users
  root 'welcome#index'
end
