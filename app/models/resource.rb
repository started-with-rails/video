class Resource < ApplicationRecord
    include FriendlyUrl
    include ResourceDefinitions
    include ResourceScopes
end
