class Category < ApplicationRecord
  include FriendlyUrl
  scope :active, -> {where(:status => true)}
  has_many :listings
  has_many :resources, through: :listings

  scope :active, -> {where(status: true)}
  scope :show_in_home, -> {where(show_in_home_page: true).active }
  scope :order_by_position, -> { order(:position)}
 
  # scope :home_resources, -> { active_resources }, class_name: "Resource"
 
  # scope :listings_by_group, -> { 
  #   select("DISTINCT ON(categories.id) categories.id, 
  #   resources.id resource_id, 
  #   categories.title, 
  #   resources.title first_resource_title").
  #   joins(:resources).
  #   order("id, resource_id desc").map{ |cat|  [cat.id, cat.title, cat.resource_id, cat.first_resource_title]}
  # }
  # Ex:- scope :active, -> {where(:active => true)}

end
