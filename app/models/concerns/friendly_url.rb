module FriendlyUrl
    extend ActiveSupport::Concern
    included do
        extend FriendlyId
        friendly_id :title, use: [:slugged, :history, :finders]

        def should_generate_new_friendly_id?
            title_changed?
        end
    end
  end