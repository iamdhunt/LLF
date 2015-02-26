LLF::Application.routes.draw do

  get "mentions/new"

  get "mentions/destroy"

  devise_scope :member do
    match '/settings' => 'registrations#settings', as: :settings
    match '/avatar' => 'registrations#avatar', as: :avatar
    authenticated :member do
      root :to => 'devise/registrations#new'
    end
    unauthenticated :member do
      root :to => 'pages#trending'
    end
  end 

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :projects do
    resources :comments
    resources :uploads
    resources :updates
    resources :follows, :controller => 'follows_projects', :only => [:create, :destroy]
    member do
      put "favorite", to: "projects#upvote"
      get 'uploads/cancel', to: "uploads#cancel"
    end
  end

  resources :events do
    resources :comments
    resources :uploads 
    resources :updates
    resources :follows, :controller => 'follows_events', :only => [:create, :destroy]
    member do
      put "favorite", to: "events#upvote"
      get 'uploads/cancel', to: "uploads#cancel"
    end
  end

  get "discover" => "search#search", :as => "search"

  get "market" => "market#market", :as => "market"

  scope 'market' do
    resources :listings do
      resources :comments
      member do
        put "favorite", to: "listings#upvote"
      end
    end
  end 

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
      put "cancel", to: "media#cancel"
    end
  end

  match '/faqs' => 'pages#faqs'
  match '/terms' => 'pages#terms'
  match '/privacy' => 'pages#privacy'
  match '/rules' => 'pages#rules'
  match '/community' => 'pages#trending'
  match '/brand-spotlights' => 'pages#brand_spotlights', :as => 'brand_spotlights'
  match '/artist-spotlights' => 'pages#artist_spotlights', :as => 'artist_spotlights'
  match '/music-spotlights' => 'pages#music_spotlights', :as => 'music_spotlights'
  match '/member-spotlights' => 'pages#member_spotlights', :as => 'member_spotlights'

  devise_for :members, :controllers => { :registrations => "registrations" }
  ActiveAdmin.routes(self)
  devise_for :members, skip: [:sessions]
  ActiveAdmin.routes(self)

  resources :messages do
    member do
      post :new
    end
  end
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      post :empty_trash
      post :polling
      post :refresh
    end
  end
  resources :notifications do
    collection do
      put 'update_all'
    end
  end

  as :member do
    get '/login' => 'devise/sessions#new', as: :new_member_session
    post '/login' => 'devise/sessions#create', as: :member_session
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_member_session
    post '/password' => 'devise/passwords#create', as: :password
    put '/password' => 'devise/passwords#update'
    put '/' => 'devise/registrations#update'
    get '/join', to: 'devise/registrations#new', as: :join
    get '/login', to: 'devise/sessions#new', as: :sign_in
    get '/logout', to: 'devise/sessions#destroy', as: :sign_out
    get '/password/new', to: 'devise/passwords#new', as: :new_password
    get '/password/edit', to: 'devise/passwords#edit', as: :edit_password
    get '/edit', to: 'devise/registrations#edit', as: :edit_member
   end  

  resources :statuses do
    resources :comments
    resources :mentions
  end 

  resources :statuses
  
  get '/:id', to: 'profiles#show', as: 'profile'

  scope '/:id' do
    get '' => 'profiles#show'
    get '/media' => 'profiles#media', as: 'profile_media'
    get '/media/new' => 'profiles#media_new', as: 'profile_media_new'
    get '/media/cancel' => 'profiles#media_cancel'
    get '/media/favorites' => 'profiles#media_fav', as: 'profile_media_fav'
    get '/stream' => 'profiles#stream', as: 'profile_stream'
    get '/stream/personal' => 'profiles#personal', as: 'profile_personal'
    get '/stream/favorites' => 'profiles#stream_fav', as: 'profile_favorites'
    get '/followers' => 'profiles#followers', as: 'profile_followers'
    get '/following' => 'profiles#following', as: 'profile_following'
    get '/projects' => 'profiles#projects', as: 'profile_projects'
    get '/projects/following' => 'profiles#projects_following', as: 'profile_projects_following'
    get '/projects/favorites' => 'profiles#projects_fav', as: 'profile_projects_fav'
    get '/events' => 'profiles#events', as: 'profile_events'
    get '/events/past' => 'profiles#events_past', as: 'profile_events_past'
    get '/events/following' => 'profiles#events_following', as: 'profile_events_following'
    get '/events/favorites' => 'profiles#events_fav', as: 'profile_events_fav'
    get '/market' => 'profiles#market', as: 'profile_market'
    match '/market/favorites' => 'profiles#market_fav', :as => 'profile_market_fav'
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
