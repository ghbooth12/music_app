class ConcertsController < ApplicationController
  before_action :set_concert, only: [:edit, :update, :destroy]

  def index
    @concerts = Concert.all
  end

  def new
    @concert = Concert.new
  end

  def create
    @concert = current_user.concerts.build(concert_params)

    if @concert.save
      flash[:notice] = "Concert was successfully created."
      if profile = current_user.profiles.first
        redirect_to edit_user_profile_path(current_user, profile)
      else
        redirect_to new_user_profile_path(current_user)
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @concert.update_attributes(concert_params)
      flash[:notice] = "Concert was successfully updated."
      if profile = current_user.profiles.first
        redirect_to edit_user_profile_path(current_user, profile)
      else
        redirect_to new_user_profile_path(current_user)
      end
    else
      render :edit
    end
  end

  def show
    @concert = Concert.find(params[:id])
  end

  def destroy
    if @concert.destroy
      flash[:notice] = "Concert was successfully deleted."
      render :index
    else
      flash.now[:alert] = "There was an error updating the concert."
      render :index
    end
  end

  private

  def set_concert
    @concert = current_user.concerts.find(params[:id])
  end

  def concert_params
    params.require(:concert).permit(:show_date, :show_time, :address_1, :address_2, :city, :state, :zipcode, :phone_number, :location_url, :body)
  end
end
