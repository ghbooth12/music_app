class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:search] && params[:miles]
      @concerts = Concert.near(params[:search], params[:miles])
      @hash = Gmaps4rails.build_markers(@concerts) do |concert, marker|
        marker.lat concert.latitude
        marker.lng concert.longitude
      end
    end
  end

  def song_list
    @profiles = Profile.all
  end
end
