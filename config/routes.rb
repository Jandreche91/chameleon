Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, except: [:destroy] do
    resources :milestones, only: [:create, :update]
  end
  resources :users, only: :index
end
