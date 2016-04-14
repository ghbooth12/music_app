class FavoritesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @favorite = current_user.favorites.build(profile: @profile)

    if @favorite.save
      @msg = "Profile favorited."
    else
      @msg = "Favoriting failed."
    end

    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @favorite = current_user.favorites.find(params[:id])

    if @favorite.destroy
      @msg = "Profile unfavorited."
    else
      @msg = "Unfavoriting failed."
    end

    respond_to do |format|
      format.js { render 'destroy.js.erb' }
    end
  end
end
