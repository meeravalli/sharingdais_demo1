Sharingdasiss::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/admin", :to => "devise/sessions#new"
    match 'auth/:provider/callback', to: 'devise/omniauth_callbacks#create'    
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

    post :post_skill_requirement, :on => :collection
    post :skill_list_availability, :on => :collection
    get :edit_skill_post_requirement, :on => :member
    get :edit_skill_list_availability, :on => :member
    delete :skill_destroy_requirement, :on => :member

    post :post_peer_service_requirement, :on => :collection
    post :peer_service_list_availability, :on => :collection
    get :edit_peer_service_post_requirement, :on => :member
    get :edit_peer_service_list_availability, :on => :member
    
    delete :peer_service_destroy_requirement, :on => :member

    

    get :shares_with_us, :on => :collection
    get :share_with_us, :on => :collection
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
  resources :peer_messages, :only => [:index, :create, :destroy] do
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
    get :review, :on => :member
  end
  get "/profile/:name" => "home#profile",:as => :prof_home

  # resources :book_search, :only => [:index]
 get "/:city/:location/food_search" => "food_search#index"
 get "/:city/:location/skill_search" => "skill_search#index"
 get "/:city/:location/book_search" => "book_search#index"  
 get "/:city/:location/peer_services" => "peer_services#index"  
  match '/book_search', :to => 'book_search#index'
  match '/food_search', :to => 'food_search#index'
  match '/skill_search', :to => 'skill_search#index'
  match '/peer_services', :to => 'peer_services#index'
 
 

  match '/home/search', :to => 'home#index'

  
  match "aboutus" => "static_pages#aboutus"
  match "ourteam" => "static_pages#ourteam"
  match "legal_terms" => "static_pages#legal_terms"
  match "hygiene_factor" => "static_pages#hygiene_factor"
  match "benefits" => "static_pages#benefits"

  post "edit_user_profile" => "admins#edit_user_profile"
  
  get "exl" => "admins#exl"
  get "post_food_exl" => "admins#post_food_exl"
  get "post_book_exl" => "admins#post_book_exl"
  get "post_skill_exl" => "admins#post_skill_exl" 
  get "list_food_exl" => "admins#list_food_exl"
  get "list_book_exl" => "admins#list_book_exl"
  get "list_skill_exl" => "admins#list_skill_exl"
  get "post_peer_exl" => "admins#post_peer_exl"
  get "list_peer_exl" => "admins#list_peer_exl"
  

  get "post_requirements" => "admins#post_requirements"
  get "list_requirements" => "admins#list_requirements"
  get "user_orders" => "admins#user_orders"
  get "user_add_clicks" => "admins#user_add_clicks"
  post "/edit_food_post" => "admins#edit_food_post"
  delete "destroy_food_post" => "admins#destroy_food_post"
  post "/edit_book_post" => "admins#edit_book_post"
  delete "destroy_book_post" => "admins#destroy_book_post"
  post "/edit_skill_post" => "admins#edit_skill_post"
  delete "destroy_skill_post" => "admins#destroy_skill_post"
  post "/edit_peer_post" => "admins#edit_peer_post"
  delete "destroy_peer_post" => "admins#destroy_peer_post"

  
  
  post "search_food" => "book_search#search_top_five_food"
  post "search_book" => "book_search#search_top_five_book"
  post "search_skill" => "book_search#search_top_five_skill"
  post "search_peer" => "book_search#search_top_five_peer"
 
  post "send_feedback" => "book_search#feedback"
  post "rate_me" => "home#rate_me"
  post "rate_me_book" => "home#rate_me_book"
  post "rate_me_skill" => "home#rate_me_skill"
  post "rate_me_peer" => "home#rate_me_peer"
  
  post "destroy_order" => "home#destroy_order"
  post "destroy_book_order" => "home#destroy_book_order"
  post "destroy_peer_order" => "home#destroy_peer_order"
  post "save_phone" => "home#save_phone"
  post "save_count" => "book_search#save_count"
  post "check_email" => "book_search#check_email"

  get "/food_result/:id/:seeker_provider/" => "food_search#food_result"
  get "/book_result/:id/:seeker_provider/" => "book_search#book_result"
  get "/skill_result/:id/:seeker_provider/" =>"skill_search#skill_result"
   get "/peer_result/:id/:seeker_provider/" => "peer_services#peer_result"
  
  get "offer" => "book_search#offer"

  get "skill_search/index"
  get "skill_search/skill_result"
  get "peer_services/index"
  get "peer_services/peer_result"
  
  
  get "close_window" => "book_search#close_window"

  get "digital_market" => "static_pages#digital_market"
  #get "choc_cake" => "static_pages#choc_cake"
  #get "home_food" => "static_pages#home_food"
  #get "ecomm_shop" => "static_pages#ecomm_shop"
  #get "marketing_stratgy" => "static_pages#marketing_stratgy"
  get "winning_way" => "static_pages#winning_way"
  get "fifty_shades_grey" => "static_pages#fifty_shades_grey"
  get "revolution_2020" => "static_pages#revolution_2020"
  get "gmat_official_edition" => "static_pages#gmat_official_edition"  
  get "yoga" => "static_pages#yoga"
  get "photography" => "static_pages#photography"
  get "bake" => "static_pages#bake"
  get "khadi_chawal" => "static_pages#khadi_chawal"
  get "stuffed_parantha" => "static_pages#stuffed_parantha"
  get "veg_thali" => "static_pages#veg_thali"
  get "veg_biryani" => "static_pages#veg_biryani"
  get "event_management" => "static_pages#event_management"
  get "tax_consultant" => "static_pages#tax_consultant"
  get "doctors_dentists" => "static_pages#doctors_dentists"
  get "beauty_baby_care" => "static_pages#beauty_baby_care"
  post "create_review" => "home#create_review"
  get "show_reviews" => "home#show_review", :as => :show_reviews
  
  get "safety_guide_book" => "static_pages#safety_guide_book"
  get "safety_guide_skill" => "static_pages#safety_guide_skill"
  get "saftey_guide_food" => "static_pages#saftey_guide_food"
 
 
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
