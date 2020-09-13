class CategoryComponent < ViewComponent::Base
    extend Forwardable
    with_collection_parameter :category
    include ViewComponent::Slotable
    attr_reader :category
    delegate [:id, :title,:slug] => :@category
    with_slot :menu_item

    def initialize(category:)
      @category = category
    end

    def videos_count
        category.video_items.count
    end
end
