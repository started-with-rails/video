
class EmbedVideoThumb

  require 'nokogiri'
  require 'open-uri'
  require 'json'
  require 'uri'
  require 'net/http'
  
  def get(embed_code, size = 'large')
    # size_parameter = { 'small', 'medium', 'large', 'max'}

    # youtube
    #   default: small - 120x90
    #   mqdefault: medium - 320x180
    #   hqdefault: high - 480x360
    #   sddefault: 640x480
    #   maxresdefault: original

    # vimeo
    #   thumbnail_small: 100x75
    #   thumbnail_medium: 200x150
    #   thumbnail_large: 640xauto

    case size
    when 'small'
      youtube_size  = 'default'
      vimeo_size    = 'thumbnail_small'
    when 'medium'
      youtube_size  = 'mqdefault'
      vimeo_size    = 'thumbnail_medium'
    when 'large'
      youtube_size  = 'sddefault'
      vimeo_size    = 'thumbnail_large'
    when 'max'
      youtube_size  = 'maxresdefault'
      vimeo_size    = 'thumbnail_large'
    else
      youtube_size  = 'sddefault'
      vimeo_size    = 'thumbnail_large'
    end
    embed_code = CGI.unescapeHTML(embed_code)
    video_id = get_id(embed_code)
    if  embed_code.include?('youtube')
      image = "https://img.youtube.com/vi/#{video_id}/#{youtube_size}.jpg"
      return image 
    elsif embed_code.include?('vimeo')
      vimeo_video_json_url = format('http://vimeo.com/api/v2/video/%s.json', video_id)
      image = begin
                JSON.parse(open(vimeo_video_json_url).read).first[vimeo_size]
              rescue StandardError
                nil
              end
      return image 
    elsif (embed_code.include? "viddler")
      image= "http://cdn-thumbs.viddler.com/thumbnail_1_#{video_id}.jpg"  
      return image
    else
      return false
    end
  end

  private

  def get_id(embed_code)
    embed_code = CGI.unescapeHTML(embed_code)
    id = if (embed_code.include? "iframe")
      Nokogiri::HTML(embed_code).css('iframe').first['src'].split("/").last.split('?').first
    elsif (embed_code.include? "object")
      Nokogiri::HTML(embed_code).css('embed').map{ |i| i['src']}.first.split('/v/').last.split('&').first
    end
    return id
    rescue => e
      Rails.logger.error("Error extracting video id from embed code: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      nil
  end

end