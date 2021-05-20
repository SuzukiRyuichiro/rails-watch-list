class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    par = bookmark_params
    par['movie'] = Movie.find(par['movie'])
    @bookmark = Bookmark.new(par)
    @bookmark.list_id = params[:list_id]
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'new'
    end
  end

  def destroy
  end

  private


  def bookmark_params
    # "bookmark"=>{"comment"=>"rewrwer", "movie"=>"2"}, "commit"=>"Create Bookmark", "list_id"=>"1"}
    params.require(:bookmark).permit(:comment, :movie)

  end
end
