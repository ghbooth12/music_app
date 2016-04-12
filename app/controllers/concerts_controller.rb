class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user
  before_action :authorize_user, except: :show
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  def new
    @concert = Concert.new
  end

  def create
    @concert = @user.concerts.build(concert_params)

    if @concert.save
      @concert.tags = Tag.make_tags(params[:concert][:tags])
      flash[:notice] = "Concert was successfully created."
      redirect_to [@concert.user, @concert]
    else
      render :new
    end
  end

  def show
    @hash = Gmaps4rails.build_markers([@concert]) do |concert, marker|
      marker.lat concert.latitude
      marker.lng concert.longitude
    end
  end

  def edit
  end

  def update
    if @concert.update_attributes(concert_params)
      @concert.tags = Tag.make_tags(params[:concert][:tags])
      flash[:notice] = "Concert was successfully updated."
      redirect_to [@concert.user, @concert]
    else
      render :edit
    end
  end

  def destroy
    if @concert.destroy
      flash[:notice] = "Concert was successfully deleted."
      redirect_to [@concert.user, @concert.user.profiles.first]
    else
      flash.now[:alert] = "There was an error updating the concert."
      redirect_to [@concert.user, @concert.user.profiles.first]
    end
  end

  private

  def concert_params
    params.require(:concert).permit(:title, :show_date, :show_time, :location_name, :address_1, :address_2, :city, :state, :zipcode, :phone_number, :location_url, :body, :genre_id)
  end

  def set_user # all
    @user = User.find(params[:user_id])
  end

  def set_concert # show, edit, update, destroy
    @concert = @user.concerts.find(params[:id])
  end

  def authorize_user # new, edit, show, edit, update, destroy
    unless current_user == @user || current_user.admin?
      flash[:alert] = "Wrong Access. Authorized Personnel Only"
      redirect_to root_path
    end
  end
end
