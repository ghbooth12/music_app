require 'soundcloud'
module ProfilesHelper
  def soundcloud_widget(soundcloud_url)
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])

    begin
      user = client.get('/resolve', url: "#{soundcloud_url}")
      tracks = client.get("/users/#{user.id}/tracks", limit: 1)
      songs = tracks.map do |track|
        embed_info = client.get('/oembed', url: track.permalink_url)
        embed_info['html']
      end
      songs.join(' ')
    rescue
    end
  end

  def visible_profiles
    # Profile.all.reject do |p|
    #   soundcloud_widget(p.soundcloud_url).blank?
    # end
    Profile.all
  end
end
