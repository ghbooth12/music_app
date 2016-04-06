require 'soundcloud'
module ProfilesHelper
  def soundcloud_widget
    # create a client object with your app credentials
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])

    # get a tracks oembed data
    track_url = 'http://soundcloud.com/forss/flickermood'
    embed_info = client.get('/oembed', :url => track_url)

    # print the html for the player widget
    embed_info['html']
  end
end
