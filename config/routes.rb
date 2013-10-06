LLF::Application.routes.draw do

  resources :media

  match '/spotlights' => 'pages#spotlights'
  match '/contests' => 'pages#contests'
  match '/faqs' => 'pages#faqs'
  match '/contact_us' => 'pages#contact_us'
  match '/terms' => 'pages#terms'
  match '/privacy' => 'pages#privacy'
  match '/rules' => 'pages#rules'
  match '/brand_spotlights' => 'pages#brand_spotlights'
  match '/artist_spotlights' => 'pages#artist_spotlights'
  match '/music_spotlights' => 'pages#music_spotlights'
  match '/member_spotlights' => 'pages#member_spotlights'

  as :member do 
    get '/join', to: 'devise/registrations#new', as: :join
    get '/sign_in', to: 'devise/sessions#new', as: :sign_in
    get '/sign_out', to: 'devise/sessions#destroy', as: :sign_out
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
  end 



  resources :statuses
    get 'stream', to: 'statuses#index', as: :stream
  
  get '/:id', to: 'profiles#show', as: 'profile'

  scope '/:id' do
    get '' => 'profiles#show'
    get '/media' => 'profiles#media', as: 'profile_media'
    get '/media/new' => 'profiles#media_new', as: 'profile_media_new'
    get '/stream' => 'profiles#stream', as: 'profile_stream'
    get '/stream/personal' => 'profiles#personal', as: 'profile_personal'
    get '/stream/my_stream' => 'profiles#my_stream', as: 'profile_my_stream'
    get '/followers' => 'profiles#followers', as: 'profile_followers'
    get '/following' => 'profiles#following', as: 'profile_following'
  end

  resources :members, :only => [:index, :show], :path => '/' do
    resources :follows, :only => [:create, :destroy]
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
