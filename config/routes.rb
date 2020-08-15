Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :video_items, only: [:new,:create]

  # home page routes
  get '/videos', to: 'home#videos', as: :videos
  get '/:category_slug', to: 'home#categories', constraints: CategoryConstraint.new, as: :category
  get '/:video_slug', to: 'home#video', constraints:VideoItemConstraint.new, as: :video
end
