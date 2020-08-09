class Listing < ApplicationRecord
    belongs_to :category
    belongs_to :resource

    # group by category
    scope :home_view_listing, -> do
      select("DISTINCT ON(category_id) category_id,resource_id").
      includes(:category,:resource).
      joins(:resource,:category).
      map{ |listing|  [listing.category.title,listing.category.slug,listing.resource.slug,listing.resource.created_at]}
    end

    scope :banner_listings, -> do
      select("DISTINCT ON(category_id) category_id,resource_id").
      includes(:category,:resource).
      joins(:resource,:category).
      where(resources: { resource_type: 'embed_code'}).
      map{ |listing|  [listing.resource.slug,listing.resource.title,]}
    end


    # scope :most_recent_by_resource, -> do
    #     from(
    #       <<~SQL
    #         (
    #           SELECT listings.*
    #           FROM listings JOIN (
    #              SELECT resource_id, max(created_at) AS created_at
    #              FROM listings
    #              GROUP BY resource_id
    #           ) latest_by_resource
    #           ON listings.created_at = latest_by_resource.created_at
    #           AND listings.resource_id = latest_by_resource.resource_id
    #         ) listings
    #       SQL
    #     )
    # end


end
