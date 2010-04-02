ActionController::Routing::Routes.draw do |map|
  
  map.resources :photos, :has_many => :comments

  
  #map.resources :comments

  map.resources :events, :has_many => :comments

  map.resources :friendships, :only => [:create, :destroy]

  map.resources :messages

  # The priority is based upon order of creation: first created -> highest priority.

map.resources :users, :has_many => [:messages, :events, :photos, :comments], :except => [:edit, :destroy]
map.resource :user_session, :only => :create

map.login 'login', :controller => 'user_sessions', :action => 'new'
map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

map.profile_edit 'profile/edit', :controller => 'users', :action => 'edit'
map.profile_destroy 'profile/destroy', :controller => 'users', :action => 'destroy'
map.message_delete 'messages/:id/delete', :controller => 'messages', :action => 'delete_from_mailbox'
map.invite_user_to_event 'users/:user_id/events/:id/invite', :controller => 'event_users', :action => 'create'
map.deny_invitation_to_event 'users/:user_id/events/:id/deny', :controller => 'event_users', :action => 'destroy'
map.sign_user_to_photo 'users/:user_id/photos/:id/sign', :controller => 'photo_users', :action => 'create'
map.deny_sing_to_photo 'users/:user_id/photos/:id/deny', :controller => 'photo_users', :action => 'destroy'

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "users", :action => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
