class CategoryComponent < ViewComponent::Base
    extend Forwardable
    with_collection_parameter :category
    attr_reader :category
    delegate [:title,:slug] => :@category

    def initialize(category:)
      @category = category
    end

    def videos_count
        category.video_items.count
    end
end
