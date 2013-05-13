SocialCinemaNet::Application.routes.draw do

  resources :u_ratings


  match 'search' => 'info#search'
  
  match 'advanced_search' => 'info#advanced_search'
  match 'advanced_search_result' => 'info#advanced_search_result'
  
  match 'register' => 'users#register', :via => :get
  match 'register' => 'users#create_user', :via => :post, :as => 'create_user'
  match 'logout' => 'users#logout', :via => :delete, :as => 'logout'
  match 'login' => 'users#new_session', :via => :post, :as => 'new_session'
  match 'login' => 'users#login', :as => 'login'
  
  match 'rate' => 'info#rate_it'
  
  match 'movie/imdb/update' => 'info#ajax_imdb_update'
  match 'movie/:id' => 'movies#show', :as => 'movie_show'
  match 'movie/:id/rate' => 'movies#rate', :as => 'movie_rate'
  
  match 'genres' => 'genres#index'
  match 'genres/:id' => 'genres#show', :as => 'genre_show'
  
  match 'users' => 'users#index'

  root :to => 'info#index'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
