  module VideoDefinitions
    extend ActiveSupport::Concern
    included do
        has_and_belongs_to_many :categories
        belongs_to :user
        enum type: { video_file: "Upload File", video_url: "Video URL", embed_code: "Embed Code" }
        enum video_thumbnail_option: { upload: "Upload feature Image", generate: "Generate video thumbnail" }
        attr_accessor :thumbnail_option
        attr_accessor :accepted_terms_and_conditions
        has_one_attached :video_file
        has_one_attached :video_thumbnail
        validates_presence_of :title,:excerpt,:video_type,:thumbnail_option
        validates_presence_of :video_url,  if: proc { |obj| obj.video_type == 'video_url' }
        validates_presence_of :embed_code, if: proc { |obj| obj.video_type == 'embed_code' }
        validate :video_file_ext, if: proc { |obj| obj.video_type == 'video_file' }
        validate :video_thumbnail_ext, if: proc { |obj| obj.thumbnail_option == 'upload' }
        validates_acceptance_of :accepted_terms_and_conditions, accept: "1", message: "You must accept the terms of service"
        validates_presence_of :categories
        after_save :set_video_thumbnail, if: proc { |obj| obj.thumbnail_option == 'generate' }
        is_impressionable :counter_cache => true, :unique => :request_hash
        acts_as_votable cacheable_strategy: :update_columns
        has_many :comments, as: :commentable

        def set_video_thumbnail
          return if video_thumbnail.attached?
          case video.video_type
          when 'video_file'
              generate_thumb_from_file(self)
          when 'video_url'
              generate_thumb_from_url(self)
          end
          # VideoThumbJob.perform_later(self)
        end


        def video_thumbnail_ext
          return unless video_thumbnail.attached?
          unless video_thumbnail.byte_size <= 5.megabyte
            errors.add(:video_thumbnail, "is too big")
          end
          acceptable_types = ["image/jpeg", "image/png"]
          unless acceptable_types.include?(video_thumbnail.content_type)
            errors.add(:video_thumbnail, "must be a JPEG or PNG")
          end
        end

        def video_file_ext
          return unless video_file.attached?
          unless video_file.byte_size <= 50.megabyte
            errors.add(:video_file, "is too big")
          end
          unless video_file.content_type.start_with?("video") && video_file.content_type.end_with?(*extension_white_list)
            errors.add(:video_file, "must be a Video")
          end
        end

        def extension_white_list
          %w(flv ogg mp4 avi wmv vob asf divx mpeg mpg)
        end

      def generate_thumb_from_file(video)
        thumb = video.video_file.preview(resize_to_limit: [200,200]).processed
        file_path = ENV['BASE_DOMAIN'].to_s + Rails.application.routes.url_helpers.rails_representation_url(thumb, only_path: true).to_s
        video.video_thumbnail.attach(io: File.open(file_path), filename: "#{video.try(:slug)}.jpg", content_type: 'image/jpg')
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            Rails.logger.info "Error : Thumbnail failed for  video #{video.title}"
        ensure
            File.delete(file_path) if File.exist?(file_path)
      end
  
      def generate_thumb_from_url(video)
        target_path = Rails.root.join("storage/uploads/tmp/#{video.slug}.jpg").to_s
        target_path_name = Pathname.new(target_path)
        target_path_name.dirname.mkpath unless File.directory?(target_path_name.dirname)
        status = %x[ffmpeg -y -i #{video.video_url} -ss 00:00:00.500 -vframes 1 -an -vf "scale=w=650:h=400:force_original_aspect_ratio=decrease" #{target_path}]
        video.video_thumbnail.attach(io: File.open(target_path_name), filename: "#{video.try(:slug)}.jpg", content_type: 'image/jpg')
        rescue => e
            Rails.logger.error e.message
            Rails.logger.error e.backtrace.join("\n")
            Rails.logger.info "Error : Thumbnail failed for  video #{video.title}"
        ensure
            File.delete(target_path) if File.exist?(target_path)
      end


    end
  end