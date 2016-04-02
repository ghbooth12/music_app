class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def songs_list
    @profiles = Profile.all
  end
end
