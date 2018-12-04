Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'pages#dashboard', as: :current_user_dashboard
  end

  root to: 'pages#home'

  resources :companies do
   resources :s_documents, only: [:index, :show, :new, :create, :destroy]
   resources :operations, only: [:index, :show, :new, :create] do
     resources :investments, only: [:index, :show, :new, :create, :edit, :update]
     resources :d_documents, only: [:index, :show]
   end
  end

  resources :d_templates
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
