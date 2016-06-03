Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'pages#home'

  resources :projects, except: :destroy do
    resources :topics, path: 'threads', except: [:destroy] do
      resources :comments, only: :create
    end
    get 'invitations', to: 'projects#invitations', as: :invitation
    post 'send_invitation', to: 'projects#send_invitation', as: :send_invitation
  end

  get 'tasks_index', to: 'pages#tasks_index', as: :tasks_index
end
