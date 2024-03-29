
Rails.application.routes.draw do

  get 'actuator_commands/index'

scope ActionController::Base.relative_url_root do  
  #get 'update/index'
  get '/users/update_api_key', to: 'users#update_api_key'
  get '/users/display_syslog:lines', to: 'users#display_syslog', as: "syslog"
  get '/users/display_kernel_log:lines', to: 'users#display_kernel_log', as: "kernel_log"
  post '/actuators/send_orders', to:'actuators#send_orders'
  post '/actuators/send_grouped_orders', to: 'actuators#send_grouped_orders'
  post '/actuators/send_forced_orders', to: 'actuators#send_forced_orders'
  
  post 'update/insert'

  root 'users#home'
  resources :devices  
  resources :sensors
  resources :actuators
  resources :reports
  resources :operations
  resources :calculated_data
  resources :users
  
  resources :range_commands
  
  resources :sessions, :only => [ :new , :create, :destroy ]
  
  get '/sensors/:id/show_operation', to: 'sensors#show_operation', as: 'sensor_show_operation'
  post '/sensors/:id/show_operation', to: 'sensors#show_operation'
  post '/devices/:id/', to: 'devices#show'
  post '/reports/:id/', to: 'reports#show'
  match '/reports_new',  :to => 'reports#new', :via => [ :get]
 
  match '/signup',  :to => 'users#new', :via => [ :get]
  match '/signin',  :to => 'sessions#new', :via => [ :get]
  match '/signout', :to => 'sessions#destroy', :via => [ :get]
  
#  get '/sensors/:id/delete_sample', to: 'sensors#delete_sample', as: 'sensor_delete_sample'
  delete '/sensors/:id/delete_sample', to: 'sensors#delete_sample', as: 'sensor_delete_sample'
  delete '/calculated_data/:id/delete', to: 'calculated_data#delete_sample', as: 'calculated_data_delete_sample'
  
  resources :dashboards
  resources :dash_board_panels
  resources :panel_items
  post '/dashboards/:id/', to: 'dashboards#show'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
end
