LLF::Application.routes.draw do

  resources :projects do
    resources :comments
    resources :uploads
    resources :updates
    resources :follows, :controller => 'follows_projects', :only => [:create, :destroy]
    member do
      put "favorite", to: "projects#upvote"
    end
  end

  get "search" => "search#search", :as => "search"

  get "community" => "community#community", :as => "community"

  resources :activities, only: [:index, :destroy] 

  resources :activities do
    member do
      put "favorite", to: "activities#upvote"
    end
  end

  resources :media do
    resources :comments
    member do
      put "favorite", to: "media#upvote"
    end
  end

  match '/faqs' => 'pages#faqs'
  match '/contact-us' => 'pages#contact_us', :as => 'contact_us'
  match '/terms' => 'pages#terms'
  match '/privacy' => 'pages#privacy'
  match '/rules' => 'pages#rules'
  match '/brand-spotlights' => 'pages#brand_spotlights', :as => 'brand_spotlights'
  match '/artist-spotlights' => 'pages#artist_spotlights', :as => 'artist_spotlights'
  match '/music-spotlights' => 'pages#music_spotlights', :as => 'music_spotlights'
  match '/member-spotlights' => 'pages#member_spotlights', :as => 'member_spotlights'

  as :member do 
    get '/join', to: 'devise/registrations#new', as: :join
    get '/sign_in', to: 'devise/sessions#new', as: :sign_in
    match '/sign-in' => 'devise/sessions#new', as: :sign_in
    get '/sign_out', to: 'devise/sessions#destroy', as: :sign_out
    match '/sign-out' => 'devise/sessions#destroy', as: :sign_out
    get '/password/new', to: 'devise/passwords#new', as: :new_password
    get '/password/edit', to: 'devise/passwords#edit', as: :edit_password
    get '/edit', to: 'devise/registrations#edit', as: :edit_member
  end 

  devise_for :members, :controllers => { :registrations => "registrations" }
  devise_for :members, skip: [:sessions]

  as :member do
     get '/sign_in' => 'devise/sessions#new', as: :new_member_session
     post '/sign_in' => 'devise/sessions#create', as: :member_session
     delete '/sign_out' => 'devise/sessions#destroy', as: :destroy_member_session
     post '/password' => 'devise/passwords#create', as: :password
     put '/password' => 'devise/passwords#update'
     put '/' => 'devise/registrations#update'
   end 

  devise_scope :member do 
      root :to => 'devise/registrations#new'
      match '/settings' => 'registrations#settings', as: :settings
      match '/avatar' => 'registrations#avatar', as: :avatar
  end 

  resources :statuses do
    resources :comments
  end 

  resources :statuses
  
  get '/:id', to: 'profiles#show', as: 'profile'

  scope '/:id' do
    get '' => 'profiles#show'
    get '/media' => 'profiles#media', as: 'profile_media'
    get '/media/new' => 'profiles#media_new', as: 'profile_media_new'
    get '/media/favorites' => 'profiles#media_fav', as: 'profile_media_fav'
    get '/stream' => 'profiles#stream', as: 'profile_stream'
    get '/stream/personal' => 'profiles#personal', as: 'profile_personal'
    get '/stream/my_stream' => 'profiles#my_stream', as: 'profile_my_stream'
    match '/stream/my-stream' => 'profiles#my_stream', as: 'profile_my_stream'
    get '/stream/favorites' => 'profiles#stream_fav', as: 'profile_favorites'
    get '/followers' => 'profiles#followers', as: 'profile_followers'
    get '/following' => 'profiles#following', as: 'profile_following'
    get '/projects' => 'profiles#projects', as: 'profile_projects'
    get '/projects/following' => 'profiles#projects_following', as: 'profile_projects_following'
    get '/projects/favorites' => 'profiles#projects_fav', as: 'profile_projects_fav'
    get '/projects/new' => 'profiles#projects_new', as: 'profile_projects_new'
  end

  resources :members, :only => [:index, :show], :path => '/' do
    resources :follows, :controller => 'follows_members', :only => [:create, :destroy]
  end

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
