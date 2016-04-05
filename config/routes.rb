Rails.application.routes.draw do
  get 'songs_list' => 'welcome#songs_list', as: :songs_list

  resources :users, only: [] do
    resources :profiles, except: [:index, :destroy]
    resources :concerts, except: :index

    delete 'profiles/remove_avatar' => 'profiles#remove_avatar', as: :remove_avatar
  end

  devise_for :users
  root 'welcome#index'
end
