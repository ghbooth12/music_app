class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :authorize_user_for_modify, only: [:edit, :update, :destroy]
  before_action :set_concert, only: [:edit, :update, :destroy]
  before_action :authorize_user_for_create, only: [:new, :create]

  def new
    @concert = Concert.new
  end

  def create
    @concert = current_user.concerts.build(concert_params)

    if @concert.save
      @concert.tags = Tag.make_tags(params[:concert][:tags])
      flash[:notice] = "Concert was successfully created."
      redirect_to [current_user, @concert]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @concert.update_attributes(concert_params)
      @concert.tags = Tag.make_tags(params[:concert][:tags])
      flash[:notice] = "Concert was successfully updated."
      redirect_to [current_user, @concert]
    else
      render :edit
    end
  end

  def show
    @concert = Concert.find(params[:id])
    @hash = Gmaps4rails.build_markers([@concert]) do |concert, marker|
      marker.lat concert.latitude
      marker.lng concert.longitude
    end
  end

  def destroy
    if @concert.destroy
      flash[:notice] = "Concert was successfully deleted."
      redirect_to [current_user, current_user.profiles.first]
    else
      flash.now[:alert] = "There was an error updating the concert."
      redirect_to [current_user, current_user.profiles.first]
    end
  end

  private

  def set_concert
    @concert = current_user.concerts.find(params[:id])
  end

  def concert_params
    params.require(:concert).permit(:title, :show_date, :show_time, :location_name, :address_1, :address_2, :city, :state, :zipcode, :phone_number, :location_url, :body)
  end

  def authorize_user_for_modify
    concert = Concert.find(params[:id])
    unless current_user == concert.user
      flash[:alert] = "You must be an admin or an author of this concert article to do that."
      redirect_to [concert.user, concert]
    end
  end

  def authorize_user_for_create
    user = User.find(params[:user_id])
    unless current_user == user
      flash[:alert] = "You can create your concert artile on your profile page."
      redirect_to [user, user.profiles.first]
    end
  end
end
