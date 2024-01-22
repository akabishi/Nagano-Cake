class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order_details = OrderDetail.page(params[:page]).per(10)
  end

end
