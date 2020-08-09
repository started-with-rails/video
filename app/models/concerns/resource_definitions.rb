  module ResourceDefinitions
    extend ActiveSupport::Concern
    included do
        has_many :listings
        has_many :categories, through: :listings
        belongs_to :user
        enum type: { source_file: "Upload File", video_url: "Video URL", embed_code: "Embed Code" }
        enum resource_thumbnail_option: { upload: "Upload feature Image", generate: "Generate video thumbnail" }
        attr_accessor :thumbnail_option
        attr_accessor :accepted_terms_and_conditions
        has_one_attached :source_file
        has_one_attached :source_thumbnail
        validates_presence_of :title,:excerpt,:resource_type,:thumbnail_option
        validates_presence_of :resource_url,  if: proc { |obj| obj.resource_type == 'video_url' }
        validates_presence_of :embed_code, if: proc { |obj| obj.resource_type == 'embed_code' }
        validate :source_file_ext, if: proc { |obj| obj.resource_type == 'source_file' }
        validate :source_thumbnail_ext, if: proc { |obj| obj.thumbnail_option == 'upload' }
        validates_acceptance_of :accepted_terms_and_conditions, accept: "1", message: "You must accept the terms of service"
        validates_presence_of :categories
        after_save :set_source_thumbnail, if: proc { |obj| obj.thumbnail_option == 'generate' }
        is_impressionable

        def set_source_thumbnail
          return unless source_file.attached? && !source_thumbnail.attached?
          VideoPreprocessJob.perform_later(self)
        end


        def source_thumbnail_ext
          return unless source_thumbnail.attached?
          unless source_thumbnail.byte_size <= 5.megabyte
            errors.add(:source_thumbnail, "is too big")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(source_thumbnail.content_type)
            errors.add(:source_thumbnail, "must be a JPEG or PNG")
          end
        end

        def source_file_ext
          return unless source_file.attached?
          unless source_file.byte_size <= 50.megabyte
            errors.add(:source_file, "is too big")
          end
          unless source_file.content_type.start_with?("video") && source_file.content_type.end_with?(*extension_white_list)
            errors.add(:source_file, "must be a Video")
          end
        end

        def extension_white_list
          %w(flv ogg mp4 avi wmv vob asf divx mpeg mpg)
        end
    end
  end