class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    belongs_to :user
    validates_presence_of :content, on: :create, message: "can't be blank"
end
