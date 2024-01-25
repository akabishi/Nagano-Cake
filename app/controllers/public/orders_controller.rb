class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @order = Order.new(order_params)
    # order パラメーター内の address パラメーターの値を取得(配送先)
    @address_type = params[:order][:select_address]
    # 選択した配送先に応じて、@order内のデータを変更
    case @address_type
    when "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when "2"
      @order.customer_id = current_customer.id
    end

    # 注文情報一覧(カート内一覧)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    # 送料
    @shipping_cost = 800
    # order パラメーター内の pay_method パラメーターの値を取得(支払方法)
    @selected_payment_method = params[:order][:payment_method]
    # 商品合計額の計算
    @cart_items_price = @cart_items.sum { |cart_item| cart_item.item.price * cart_item.amount }
    # 請求金額
    @total_price = @shipping_cost + @cart_items_price

    render :confirm

  end

  def create
    # hidden_fieldを作るのに使う
    order = Order.new(order_params)
    order.save

    # カート内商品の情報を取得
    @cart_items = current_customer.cart_items.all

    # OrderDetailの各フィールドに値を設定
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.with_tax_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      # データベースに保存
      @order_details.save!
    end

    CartItem.destroy_all
    redirect_to thanks_path

  end

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    # OrderDetailモデルからorder_idが@order.idと一致するレコードを取得
    @order_details= OrderDetail.where(order_id: @order.id)
  end

  def thanks
  end

  def error
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :total_price, :shipping_cost, :status)
  end

end
