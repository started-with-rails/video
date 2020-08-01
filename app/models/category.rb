class Category < ApplicationRecord
  include FriendlyUrl
  scope :active, -> {where(:status => true)}
  has_and_belongs_to_many :resources

end
