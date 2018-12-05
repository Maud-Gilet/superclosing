Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing'
  authenticated :user do
    root 'pages#home'
  end



  resources :companies do
   resources :s_documents, only: [:index, :show, :new, :create, :destroy]
   resources :operations, only: [:index, :new, :create] do
     resources :investments, only: [:index, :show, :new, :create, :edit, :update]
     resources :d_documents, only: [:index, :show]
   end
  end
  resources :operations, only: :show
  resources :d_templates
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
