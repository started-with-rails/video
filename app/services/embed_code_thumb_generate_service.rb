class EmbedCodeThumbGenerateService
    attr_reader :video
   
    def initialize(video)
      @video = video
    end

    def call
        get_thumbnail_from_embed_code
    end

    private

  
    def get_thumbnail_from_embed_code
        return  unless get_video_id.present?
        video_id = get_video_id
        embed_code = CGI.unescapeHTML(video.embed_code)
        thumbnail= if (embed_code.include? "youtube")
            "http://img.youtube.com/vi/#{video_id}/maxresdefault.jpg"
        elsif (embed_code.include? "viddler")
            "http://cdn-thumbs.viddler.com/thumbnail_1_#{video_id}.jpg"
        elsif (embed_code.include? "vimeo")
            api_call = "https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{video_id}"
            result = JSON.parse(`curl #{api_call}`)
            result["thumbnail_url"]
        else
            nil
        end
        thumbnail
        rescue => e
        Rails.logger.error("Error extracting video thumbnail from embed code: #{e.message}")
        Rails.logger.error(e.backtrace.join("\n"))
        nil
    end

    # Video ID extraction from embed codes supported for:
    #  1) YouTube  (embed-iframe, embed-object, url)
    #  2) Wistia   (embed-iframe)
    #  3) Vimeo    (embed-iframe)
    def get_video_id
      return unless video.try(:embed_code).present? 
      embed_code = CGI.unescapeHTML(video.embed_code)
      html = Nokogiri::HTML.parse(embed_code)
      video_id = if (embed_code.include? "iframe")
        Nokogiri::HTML(embed_code).css('iframe').first['src'].split("/").last.split('?').first
      elsif (embed_code.include? "object")
        Nokogiri::HTML(embed_code).css('embed').map{ |i| i['src']}.first.split('/v/').last.split('&').first
      end
      video_id
    rescue => e
      Rails.logger.error("Error extracting video id from embed code: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      nil
    end

end