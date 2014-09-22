Sharingdasiss::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/admin", :to => "devise/sessions#new"
  end

  resources :sharing, :only =>[:index] do    
    post :post_requirement, :on => :collection
    post :list_availability, :on => :collection
    get :edit_post_requirement, :on => :member
    get :edit_list_availability, :on => :member
    delete :destroy_requirement, :on => :member

    post :post_book_requirement, :on => :collection
    post :book_list_availability, :on => :collection
    get :edit_book_post_requirement, :on => :member
    get :edit_book_list_availability, :on => :member
    delete :book_destroy_requirement, :on => :member
  end
  
  resources :application do
    get :get_locations, :on => :collection
    get :get_trending_locations, :on => :collection
  end
  
  resources :admins do
    get :view_user_profile_activity, :on => :member
    get :activate_user, :on => :member
    delete :destroy_user, :on => :member
  end
  

  resources :messages, :only => [:index, :create, :destroy] do
    get :read, :on => :member
    get :cancel, :on => :member
    get :unread, :on => :collection
    get :sent, :on => :collection
    get :trash, :on => :collection
    get :agree_share, :on => :collection
  end

  resources :book_messages, :only => [:index, :create, :destroy] do
    get :read, :on => :member
    get :cancel, :on => :member
    get :unread, :on => :collection
    get :sent, :on => :collection
    get :trash, :on => :collection
    get :agree_share, :on => :collection
  end

  resources :home, :only =>[:index] do
    post :search, :to => 'home#index',:on => :collection
    get :profile, :on => :member
    get :edit_profile, :on => :member
  end

  # resources :book_search, :only => [:index]
  
  match '/book_search', :to => 'book_search#index'
  match '/food_search', :to => 'food_search#index'

  match '/home/search', :to => 'home#index'

  
  match "aboutus" => "static_pages#aboutus"
  match "ourteam" => "static_pages#ourteam"
  match "legal_terms" => "static_pages#legal_terms"
  match "hygiene_factor" => "static_pages#hygiene_factor"
  match "benefits" => "static_pages#benefits"

  post "edit_user_profile" => "admins#edit_user_profile"
  get "exl" => "admins#exl"
  get "post_requirements" => "admins#post_requirements"
  get "list_requirements" => "admins#list_requirements"
  get "user_orders" => "admins#user_orders"

  post "search_food" => "book_search#search_top_five_food"
  post "search_book" => "book_search#search_top_five_book"

  get "/food_result/:id/:seeker_provider/" => "food_search#food_result"
  get "/book_result/:id/:seeker_provider/" => "book_search#book_result"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
       
  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
