class Public::SearchesController < ApplicationController
  
  def search_genre
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id).page(params[:page]).per(8)
  end
  
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    if @range == "商品"
      @items = Item.looks(@search, @word)
      @genres = Genre.all

      # HTMLフォーマットのリクエストに対するテンプレートを返す
      respond_to do |format|
        format.html
      end
    end
  end
end
