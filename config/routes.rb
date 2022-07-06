Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount ActionCable.server => '/cable'

  # Devise (login/logout) for HTML requests
  devise_for :users, defaults: { format: :html }

  # API namespace, for JSON requests at /api/sign_[in|out]
  namespace :api do
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
        namespace :v1 do
          post "/create_sended_news", to: "sended_news#create_sended_news"
          post "/get_images", to: "sended_news#get_images"
          post "/upload_profile_image", to: "users#upload_profile_image"
          post "/send_email", to: "users#send_email"

          # for news          
          post '/searchNews', to: 'added_news#search_news'
          post '/takeNews', to: 'added_news#take_news'
          # for donations
          post '/takeDonations', to: 'donations#take_donations'
          # for users
          post '/updateContactInfo', to: 'users#update_contact_info'
          post '/searchUser', to: 'users#search_user'
          post '/updateUser', to: 'users#update_user_info'
          post '/forgotPassword', to: 'users#forgot_password'
          post '/register', to: 'users#register'
          post '/loginWithToken', to: 'users#login_with_token'
          post '/updatePass', to: 'users#update_password'
        end
  end


  root to: "home#index"
  resources :added_news do
    post "sort_images", on: :member
    get "delete_image", on: :member
  end
end
