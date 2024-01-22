class Public::SearchesController < ApplicationController
  
  def search_genre
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id).page(params[:page]).per(8)
  end
end
