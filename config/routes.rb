Rails.application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  authenticated :user do
    root 'pages#home'
  end

  root 'pages#landing'

  get 'new_investor', to: 'operations#new_investor', as: 'new_investor'
  post 'new_investor', to: 'operations#create_investor', as: 'create_investor'

  resources :companies do
    resources :operations, only: [:index, :new, :create] do
      resources :investments, only: [:index, :show, :new, :create, :edit, :update]
      resources :d_documents, only: [:index, :show]
      resources :s_documents, only: [:index, :show, :new, :create, :destroy]
    end
  end

  resources :operations, only: :show

  resources :d_templates
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
