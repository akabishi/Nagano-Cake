class Admin::ItemsController < ApplicationController
<<<<<<< HEAD
  def index
=======
     def index
>>>>>>> origin/develop
    # @items = Item.all
    # ページネーションを使いたい場合は Kaminari や will_paginate などの gem をインストールする必要があります
  # 例: Kaminari を使用する場合
  # Kaminari を使用してページネーションする
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
     @item = Item.find(params[:id])
<<<<<<< HEAD

    if @item.update(item_params)

=======
   
    if @item.update(item_params)
      
>>>>>>> origin/develop
      redirect_to admin_items_path(@item.id)
    else
      redirect_to edit_admin_item_path(@item.id)
    end
<<<<<<< HEAD

=======
    
>>>>>>> origin/develop
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image) #( :body )をpermit内へ追加
  end
<<<<<<< HEAD
=======

>>>>>>> origin/develop
end
