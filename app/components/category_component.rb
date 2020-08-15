class CategoryComponent < ViewComponent::Base
    with_collection_parameter :category
    attr_reader :category

    def initialize(category:)
      @category = category
    end

    def title
        category.title
    end

    def slug
        category.slug
    end
end
