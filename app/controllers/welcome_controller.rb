class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:search] && params[:miles]
      @concerts = Concert.near(params[:search], params[:miles])
    else
      @concerts = Concert.all
    end
  end

  def song_list
    @profiles = Profile.all
  end
end
