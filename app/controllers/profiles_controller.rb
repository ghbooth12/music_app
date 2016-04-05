class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :authorize_user_for_modify, only: [:edit, :update]
  before_action :set_profile, only: [:edit, :update]
  before_action :authorize_user_for_create, only: [:new, :create, :remove_avatar]

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

  def remove_avatar
    profile = current_user.profiles.first
    profile.remove_avatar!
    if profile.save
      redirect_to [current_user, profile]
    else
      render :show
    end
  end

  private

  def set_profile
    @profile = current_user.profiles.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:avatar, :facebook_url, :twitter_url, :youtube_url, :soundcloud_url, :body)
  end

  def authorize_user_for_modify
    profile = Profile.find(params[:id])
    unless current_user == profile.user
      flash[:alert] = "You must be an admin or an owner of this profile page to do that."
      redirect_to [profile.user, profile]
    end
  end

  def authorize_user_for_create
    user = User.find(params[:user_id])
    unless current_user == user
      flash[:alert] = "You can do that on your profile page."
      redirect_to [user, user.profiles.first]
    end
  end
end
