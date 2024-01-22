class Admin::SearchController < ApplicationController
  def index
    @query = params[:query]
    @items, @customers = perform_search(@query)
  end

  private

  def perform_search(query)
    # 検索処理を実装する
    # 例: 商品と会員を検索する
    items = Item.where('name LIKE ?', "%#{query}%")
    customers = Customer.where('name LIKE ? OR email LIKE ?', "%#{query}%", "%#{query}%")

    [items, customers]
  end
end
