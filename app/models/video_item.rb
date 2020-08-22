require 'elasticsearch/model'
class VideoItem < ApplicationRecord
    include FriendlyUrl
    include VideoDefinitions
    include VideoScopes
    include Searchable
end