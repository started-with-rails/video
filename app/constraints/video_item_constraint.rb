class VideoItemConstraint
    def matches?(request)
      VideoItem.where(slug: request.path_parameters[:video_slug]).exists?
    end
end
  