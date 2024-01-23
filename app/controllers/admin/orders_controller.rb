class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def show
    @order_details = @order.order_details.all
    # 各注文の price * amount の合計値を計算し表示
    @order_product_total = 0
    @order_details.each do |order_detail|
      order_total = order_detail.price * order_detail.amount
      @order_product_total += order_total
    end
  end

  def update
    @order_details = @order.order_details
    if @order.update(order_params)
       @order_details.update_all(making_status: "制作待ち") if @order.status == "入金確認"
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :payment_method, :status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
