Rails.application.routes.draw do
  root 'home#index'
  get 'spotify_tokens/callback', to: 'spotify_tokens#callback'
  resources :spotify_tokens, only: :new
  resources :spotify_searches, only: :index
  resources :apple_music_searches, only: :index
  delete 'sessions', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
