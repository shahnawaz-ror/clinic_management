Rails.application.routes.draw do
  devise_for :users

  authenticate :user, lambda { |u| u.role == 'receptionist' } do
    resources :receptionists, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  authenticate :user, lambda { |u| u.role == 'doctor' } do
    resources :doctors, only: [:index]
    get 'doctors/graph', to: 'doctors#graph'
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
