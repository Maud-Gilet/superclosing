Rails.application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  authenticated :user do
    root 'pages#home'
  end

  root 'pages#landing'


  resources :companies do
    resources :captables, only: [:show, :new, :create]
    post 'new_nominal', to: 'companies#create_nominal', as: 'create_nominal'

    resources :s_documents, only: [:index, :show, :new, :create, :destroy]

    resources :operations, only: [:index, :new, :create] do
      resources :investors, only: [:index, :new, :create]
      resources :investments, only: [:index, :new, :create]
      resources :s_documents, only: [:index, :show, :new, :create, :destroy]
    end
  end


  resources :operations, only: :show do
    member do
      post "create_documents", to: "d_documents#create_documents"
      # post "/operations/:id/create_documents", to: "d_documents#create_documents"
    end
    resources :d_documents, only: [:index]
  end
  resources :d_documents, only: :show
  resources :investments, only: [:show, :edit, :update, :destroy]
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
