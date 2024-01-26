class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def show
    # @orderに紐づいた全ての注文明細 (OrderDetail) を取得して、@order_detailsに代入
    @order_details = @order.order_details.all
    # 各注文の price * amount の合計値を計算し表示
    @order_product_total = 0
    @order_details.each do |order_detail|
      order_total = order_detail.price * order_detail.amount
      @order_product_total += order_total
    end
  end

  def index
    # 対応する顧客 (Customer) オブジェクトをデータベースから取得し、@customerに代入
    @customer = Customer.find(params[:customer_id])
    @name = @customer.first_name + @customer.last_name
    # 顧客に紐づいた注文 (@customer.orders) をページネーションを適用して取得し、@ordersに代入
    @orders = @customer.orders.page(params[:page]).per(10)
  end

  def update
    # 注文 (@order) のステータスを、
    # コントローラーから送信されたパラメータ params[:order][:status] の値で更新
    @order.update(status: params[:order][:status])
    # @orderに紐づいた注文明細 (OrderDetail) のコレクションを取得して、order_detailsに代入
    order_details = @order.order_details

    # 注文 (@order) のステータスが "payment_confirmed" である場合、
    # 注文に紐づいたすべての注文明細 (order_details) の making_status を "waiting_making" に更新する条件文
    if params[:order][:status] == "payment_confirmed"
       order_details.update(making_status:"waiting_making")
    end

    flash[:notice] = "更新に成功しました。"
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :payment_method, :status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
