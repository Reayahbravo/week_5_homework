Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # # /admin/...
  # namespace :admin do
  #   # The `namespace` method takes a symbol as a first argument
  #   # and a block. It will prefix the symbol's name to the
  #   # path of all routes defined inside the block.
  #   # GET /admin/dashboard
  #   resources :dashboard, only: [:index]

  #   # It will expect that the controllers for the routes
  #   # inside block to be contained in a module named after
  #   # the symbol.
  #   # Example: Admin::DashboardController

  #   # It will also expect the controllers to be in a sub-directory
  #   # named after the symbol.
  #   # Example: /app/controllers/admin/dashboard_controller.rb

  #   # GET /admin/users
  #   # POST /admin/users
  #   # GET /admin/users/:id
  #   # resources :users
  
    # `resource` is singular instead of `resources`.
  # Unlike `resources`, `resource` will create routes
  # that do CRUD operation on only one thing. There
  # will be no index routes and no route will
  # have a `:id` wild card. When using a singular resource,
  # the controller must still be plural.
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :update, :edit]
  
    
  

  resources :posts do
    #get :my_route
    resources :comments, only: [:create, :destroy]

    # The above method call `resources :questions`
  # will exactly create all RESTful routes as written below:
  end
  # we map HTTP verb/url combo to a controller#action (action is a method inside the controller class)
  get('/', { to: 'posts#index', as: 'home' })

  get('/comment', { to: 'comment#index' })
  post('/comment_submit', { to: 'comment#create' })
end