Rails.application.routes.draw do

  get 'user_index', to:'admins#user_index', as: 'admins_user_index'

  get 'set_user/:id', to: 'admins#set_user', as: 'admins_set_user'

  get 'set_post/:post_id', to: 'admins#set_post', as: 'admins_set_post'

  get 'chenge/:id', to: 'admins#chenge', as: 'admins_chenge'

  get 'user_comments/:id', to: 'admins#user_comments', as: 'admins_user_comments'

  get 'post_comments/:post_id', to: 'admins#post_comments', as: 'admins_post_comments'

  get 'user_posts/:id', to: 'admins#user_posts', as: 'admins_user_posts'

  get 'about' => "about#about"

  devise_for :users

  resources :posts do
    resources :comments,  except: [:show, :index, :edit, :update, :show]
  end

  root "posts#index"

  get 'user/:id', to: 'posts#userindex', as: "user_posts"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
