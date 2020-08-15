class VideoItem < ApplicationRecord
    include FriendlyUrl
    include VideoDefinitions
    include VideoScopes
end
