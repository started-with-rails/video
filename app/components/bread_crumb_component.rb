class BreadCrumbComponent < ViewComponent::Base
  def initialize(breadcrumbs:)
    @breadcrumbs = breadcrumbs
  end
end
