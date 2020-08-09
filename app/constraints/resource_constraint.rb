class ResourceConstraint
    def matches?(request)
      Resource.where(slug: request.path_parameters[:video_slug]).exists?
    end
end
  