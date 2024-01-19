Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    resources :books, only: [:index, :show, :create, :destroy]
    resources :reservations
  end
end
