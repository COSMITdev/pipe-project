Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :projects, except: :destroy do
    resources :topics, except: [:index, :destroy]
  end
end
