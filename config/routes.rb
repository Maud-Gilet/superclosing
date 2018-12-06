Rails.application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  authenticated :user do
    root 'pages#home'
  end

  root 'pages#landing'



  get 'new_investor', to: 'operations#new_investor', as: 'new_investor'
  post 'new_investor', to: 'operations#create_investor', as: 'create_investor'

  resources :companies do
    get 'new_captable', to: 'companies#new_captable', as: 'new_captable'
    post 'new_captable', to: 'companies#create_captable', as: 'create_captable'
    post 'new_nominal', to: 'companies#create_nominal', as: 'create_nominal'

    resources :s_documents, only: [:index, :show, :new, :create, :destroy]
    resources :operations, only: [:index, :new, :create] do
      resources :investments, only: [:index, :new, :create, :edit, :update]
      resources :d_documents, only: [:index, :show]
    end
  end

  resources :operations, only: :show
  resources :investments, only: [:show, :destroy]
  resources :d_templates
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
