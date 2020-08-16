Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :video_items, only: [:new,:create]

  resources :video_items do 
    member do
      put "like", to: "video_items#upvote"
      put "dislike", to: "video_items#downvote"
    end
  end

  # home page routes
  get '/videos', to: 'home#videos', as: :videos
  get '/:category_slug', to: 'home#categories', constraints: CategoryConstraint.new, as: :category
  get '/:video_slug', to: 'home#video', constraints:VideoItemConstraint.new, as: :video
end
