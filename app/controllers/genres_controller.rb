class GenresController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :admin_user?, except: [:index, :show]
  before_action :set_genre, only: [:edit, :update, :destroy, :show]

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      flash[:notice] = "Genre was successfully created."
      redirect_to @genre
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @genre.update_attributes(genre_params)
      flash[:notice] = "Genre was successfully updated."
      redirect_to @genre
    else
      render :edit
    end
  end

  def destroy
    if @genre.profiles.any?
      flash[:alert] = "If any profile belongs to the genre, the genre cannot be deleted."
      redirect_to @genre
    else
      if @genre.destroy
        flash[:notice] = "Genre was successfully deleted."
        redirect_to root_path
      else
        render :edit
      end
    end
  end

  def show
  end

  private

  def admin_user?
    unless current_user && current_user.admin?
      flash[:alert] = "Admin Only"
      redirect_to root_path
    end
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
