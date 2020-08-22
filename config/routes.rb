Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get :blog, to: 'home#blog', as: :blog
  get :about_us, to: 'home#about_us', as: :about_us
  get :faqs, to: 'home#faqs', as: :faqs
  resources :video_items, only: [:new,:create]

  resources :video_items do 
    resources :comments
    member do
      put "like", to: "video_items#upvote"
      put "dislike", to: "video_items#downvote"
    end
  end

  # home page routes
  match 'search/(:tab)', to: 'home#search', as: :search, via: [:get,:post]
  get '/videos/(:tab)', to: 'home#videos', as: :videos #tab optional parameter
  get '/:category_slug/(:tab)', to: 'home#categories', constraints: CategoryConstraint.new, as: :category
  get '/:video_slug', to: 'home#video', constraints:VideoItemConstraint.new, as: :video
end
