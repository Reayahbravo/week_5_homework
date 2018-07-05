Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    #get :my_route
    resources :comments, only: [:create, :destroy]
  end
  get('/', { to: 'posts#index', as: 'home' })

  get('/comment', { to: 'comment#index' })
  post('/comment_submit', { to: 'comment#create' })
end