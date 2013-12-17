OnlineShopping::Application.routes.draw do

  get "carts/index"
  get "carts/new"
  get "carts/create"
  get "carts/edit"
  get "carts/update"
  get "carts/show"
  get "bills/index"
  get "bills/new"
  get "bills/create"
  get "bills/show" 

  resources :bills
get '/bills/display_bill', :controller => 'bills', :action => 'display_bill'
 get '/homes/generate_bill', :controller => 'homes', :action => 'generate_bill'
  resources :homes

  resources :carts do 
    collection do
      get :index
    end
  end

  devise_for :users, :controllers => { registrations: 'users/registrations'  }    
  get "addresses/index"
  get "roles/index"
  get "categories/index"

  # devise_for :users
  root 'homes#index'
  #get "homes/index"
  match 'subcategory/:id' => 'homes#subcategory', as: :homes_subcategory, via: [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #get 'products/:id', to: 'products#show', as: 'product'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :categories
  resources :roles
  resources :addresses
  resources :products
  resources :product_details

  #match "products/:name", to: 'products#show', as: :name, via: [:get]


  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
