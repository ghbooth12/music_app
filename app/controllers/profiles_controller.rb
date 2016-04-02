class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_profile, only: [:update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.profiles.build(profile_params)

    if @profile.save
      flash[:notice] = "Your profile was successfully created."
      redirect_to [current_user, @profile]
    else
      render :new
    end
  end

  def edit
    unless @profile = current_user.profiles.find(params[:id])
      render :new
    end
  end

  def update
    if @profile.update_attributes(profile_params)
      flash[:notice] = "Your profile was successfully updated."
      redirect_to [current_user, @profile]
    else
      render :edit
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def set_profile
    @profile = current_user.profiles.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:facebook_url, :twitter_url, :youtube_url, :soundcloud_url, :body)
  end
end
