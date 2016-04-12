require 'soundcloud'
module SongsHelper
  def premium_soundcloud(track)
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])

    begin
      embed_info = client.get('/oembed', url: track)
      embed_info['html']
    rescue
    end
  end
end
