class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end

end
