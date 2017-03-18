Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
#blogsにcommentsをネストはマスト
  resources :blogs, only: [:index,:show, :new,:create, :edit, :update, :destroy] do
    member do
      get :liking_users
    end
    #resources :likes
  resources :comments
    collection do
      post :confirm
    end
  end

  resources :contacts, only: [:new, :create, :confirm ] do
    collection do
      post :confirm
    end
  end

post '/like/:blog_id' => 'likes#like', as: 'like'
delete '/unlike/:blog_id' => 'likes#unlike', as: 'unlike'

root 'top#index'
#タスクはユーザに紐付くため、ルーティングはユーザのルーティング下にネスト（階層化）させる必要があるため
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :like_blogs
  end
  resources :tasks
  resources :submit_requests , shallow: true do
    get 'approve'
    get 'unapprove'
    get 'reject'
    collection do
      get 'inbox'
    end
  end
end

  resources :relationships, only: [:create, :destroy, :edit, :update] do
  end

  resources :conversations do
    resources :messages
  end

end
