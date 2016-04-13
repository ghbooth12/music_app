class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    params[:miles] ||= 20
    if params[:search]
      @concerts = Concert.near(params[:search], params[:miles])
      @hash = Gmaps4rails.build_markers(@concerts) do |concert, marker|
        marker.lat concert.latitude
        marker.lng concert.longitude
        marker.infowindow concert.title
      end
    end
  end

  def musician_list
  end

  def concert_list
  end
end
