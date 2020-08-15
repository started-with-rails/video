module BreadCrumbs
  extend ActiveSupport::Concern
  included do
    before_action :set_breadcrumbs

    def add_breadcrumb(lable, path = nil)
      @breadcrumbs << {
          label: lable,
          path: path
      }
    end

    def set_breadcrumbs
      @breadcrumbs = []
    end
  end
end