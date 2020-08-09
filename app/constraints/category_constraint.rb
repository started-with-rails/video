class CategoryConstraint
    def matches?(request)
      Category.where(slug: request.path_parameters[:category_slug]).exists?
    end
end
  