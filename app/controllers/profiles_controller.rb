class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :authorize_user, except: :show
  before_action :allow_one_profile, only: [:new, :create]

  def index
    @profiles = @user.favorites.map {|f| Profile.find_by(id: f.profile_id) }
    @active = :profiles
  end

  def new
    @profile = Profile.new
    @active = :new_profile
  end

  def create
    @profile = @user.profiles.build(profile_params)

    if @profile.save
      @profile.tags = Tag.make_tags(params[:profile][:tags])
      flash[:notice] = "Your profile was successfully created."
      redirect_to [@profile.user, @profile]
    else
      render :new
    end
  end

  def show
  end

  def edit
    @active = :edit_profile
  end

  def update
    if @profile.update_attributes(profile_params)
      @profile.tags = Tag.make_tags(params[:profile][:tags])
      flash[:notice] = "Your profile was successfully updated."
      redirect_to [@profile.user, @profile]
    else
      render :edit
    end
  end

  def remove_avatar
    profile = @user.profiles.find(params[:profile_id])
    profile.remove_avatar!
    if profile.save
      redirect_to edit_user_profile_path(profile.user, profile)
    else
    end
  end

  private

  def profile_params # create, update
    params.require(:profile).permit(:avatar, :facebook_url, :twitter_url, :youtube_url, :soundcloud_url, :body, :genre_id, :avatar_cache)
  end

  def set_user # all
    @user = User.friendly.find(params[:user_id])
  end

  def set_profile # show, edit, update
    @profile = @user.profiles.find(params[:id])
  end

  def authorize_user # new, create, edit, update, remove_avatar
    unless current_user == @user || current_user.admin?
      flash[:alert] = "Wrong Access. Authorized Personnel Only"
      redirect_to root_path
    end
  end

  def allow_one_profile # new, create
    profile = @user.profiles.first
    if profile
      flash[:alert] = "Profile already exists."
      redirect_to [profile.user, profile]
    end
  end
end
