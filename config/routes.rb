Rails.application.routes.draw do
  get 'songs_list' => 'welcome#songs_list', as: :songs_list

  resources :users, only: [] do
    resources :profiles, except: [:index, :destroy]
  end

  devise_for :users
  root 'welcome#index'
end
