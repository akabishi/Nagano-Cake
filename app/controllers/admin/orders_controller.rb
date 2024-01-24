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
    @order.update(status: params[:order][:status])
    order_details = @order.order_details

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
