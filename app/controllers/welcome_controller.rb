class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    params[:miles] ||= 20
    if params[:search]
      @concerts = Concert.upcoming_date.near(params[:search], params[:miles])
      @hash = Gmaps4rails.build_markers(@concerts) do |concert, marker|
        marker.lat concert.latitude
        marker.lng concert.longitude
        marker.infowindow concert.title
      end
    end

    @john = User.find_by(username: "John Doe")
    @tester = User.find_by(username: "Test User")
  end

  def musician_list
  end

  def concert_list
  end

  def auto_sign
    tester = User.find_by(username: "Test User")
    sign_in(tester)
    redirect_to root_path
  end

  def demo_search
    redirect_to "/?search=san+francisco#search-btn"
  end
end
