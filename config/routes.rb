Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :resources, only: [:new,:create]

  # home page routes
  get '/:category_slug', to: 'home#categories', constraints: CategoryConstraint.new, as: :category
  get '/:video_slug', to: 'home#video', constraints: ResourceConstraint.new, as: :video
end
