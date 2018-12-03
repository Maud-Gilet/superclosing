Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  authenticated :user do
    root 'pages#dashboard', as: :current_user_dashboard
  end

  resources :companies do
   resources :static_documents, only: [:index, :show, :new, :create, :destroy]
   resources :operations, only: [:index, :show, :new, :create] do
     resources :investments, only: [:index, :show, :new, :create, :edit, :update]
     resources :dynamic_documents, only: [:index, :show]
   end
  end

  resources :dynamic_templates
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
