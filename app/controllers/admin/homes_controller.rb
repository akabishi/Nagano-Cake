class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page]).per(10)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
