Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount ActionCable.server => '/cable'

  # Devise (login/logout) for HTML requests
  devise_for :users, defaults: { format: :html }

  # API namespace, for JSON requests at /api/sign_[in|out]
  namespace :api do
    resources :added_news
    post "/create_sended_news", to: "sended_news#create_sended_news"
    devise_for :users, defaults: { format: :json },
    class_name: 'ApiUser',
    skip: [:registrations, :invitations,
      :passwords, :confirmations,
      :unlocks],
      path: '',
      path_names: { sign_in: 'login',
        sign_out: 'logout' }
        devise_scope :user do
          get 'login', to: 'sessions#create'
          delete 'logout', to: 'devise/sessions#destroy'
        end
  end



  root to: "home#index"
  resources :added_news do
    post "sort_images", on: :member
    get "delete_image", on: :member
  end
end
