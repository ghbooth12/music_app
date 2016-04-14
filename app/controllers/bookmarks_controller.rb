class BookmarksController < ApplicationController
  def create
    @concert = Concert.find(params[:concert_id])
    @bookmark = current_user.bookmarks.build(concert: @concert)

    if @bookmark.save
      @msg = "Concert bookmarked."
    else
      @msg = "Bookmarking failed."
    end

    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  def destroy
    @concert = Concert.find(params[:concert_id])
    @bookmark = current_user.bookmarks.find(params[:id])

    if @bookmark.destroy
      @msg = "Bookmark removed."
    else
      @msg = "Removing bookmark failed."
    end

    respond_to do |format|
      format.js { render 'destroy.js.erb' }
    end
  end
end
