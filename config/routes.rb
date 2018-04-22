Rails.application.routes.draw do
  
  get 'static_pages/contact'

  get 'static_pages/terms_and_conditions'

  devise_for :users
  #get 'store/index'

  get 'admin' => 'admin#index'
  
  root 'store#index', as: 'store_index'
  
  
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
    
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :charges
  resources :products
  
  get 'search_results' => 'store#search_results', as: 'search_results'  #for the user to search the products
  #using get so the results can be bookmarked
  
  
  
  
  
  resources :products do
    get :who_bought, on: :member
  end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  
end






