ActionController::Routing::Routes.draw do |map|
  map.resources :dependencies

  map.resources :projects do |project|
    project.resources :discussions do |discussion|
      discussion.resources :posts
    end
  end

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.dashboard '/dashboard', :controller => 'users', :action => 'show'
  map.resources :users
  map.resource :session

  map.resources :projects do |project|
    project.resources :tasks do |task|
      task.resources :assignments
    end
    project.resources :memberships
  end
  
  map.xml_project '/projects/:project_id/gen_xml', :controller => 'projects', :action => 'gen_xml'
  map.gantt_project '/projects/:project_id/gantt', :controller => 'projects', :action => 'gantt'

  map.complete_project_task '/projects/:project_id/tasks/:task_id/complete', :controller => 'tasks', :action => 'complete'
  map.reopen_project_task '/projects/:project_id/tasks/:task_id/reopen', :controller => 'tasks', :action => 'reopen'

  map.take_project_task_assignment '/projects/:project_id/tasks/:task_id/assignments/:id/take', :controller => 'assignments', :action => 'take'
  map.drop_project_task_assignment '/projects/:project_id/tasks/:task_id/assignments/:id/drop', :controller => 'assignments', :action => 'drop'
  map.complete_project_task_assignment '/projects/:project_id/tasks/:task_id/assignments/:id/complete', :controller => 'assignments', :action => 'complete'
  map.uncomplete_project_task_assignment '/projects/:project_id/tasks/:task_id/assignments/:id/uncomplete', :controller => 'assignments', :action => 'uncomplete'

  map.root :controller => :projects, :action => :home
  

  
  # The priority is based upon order of creation: first created -> highest priority.

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
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '*path', :controller => 'application', :action => 'rescue_404' unless ::ActionController::Base.consider_all_requests_local
end
