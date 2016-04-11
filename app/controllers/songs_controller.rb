class SongsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    @songs = @user.songs
  end

  def new
    @song = @user.songs.new
  end

  def create
    @song = @user.songs.build(song_params)

    if @song.save
      flash[:notice] = "Song was successfully saved."
      redirect_to user_songs_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @song.update_attributes(song_params)
      flash[:notice] = "Song was successfully updated."
      redirect_to user_songs_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @song.destroy
      flash[:notice] = "Song was successfully deleted."
      redirect_to user_songs_path(@user)
    else
      redirect_to user_songs_path(@user)
    end
  end

  private

  def set_user # all
    @user = User.find(params[:user_id])
  end

  def authorize_user
    unless current_user == @user && (current_user.admin? || current_user.premium?)
      flash[:alert] = "Wrong Access. Authorized Personnel Only"
      redirect_to [@user, @user.profiles.first]
    end
  end

  def set_song
    @song = @user.songs.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:song_url)
  end
end
