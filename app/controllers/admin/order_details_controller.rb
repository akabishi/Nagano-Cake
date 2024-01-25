class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(making_status: params[:order_detail][:making_status])
    order = @order_detail.order
    
    if params[:order_detail][:making_status] == "in_making"
       order.update(status:"making")
    end

    if is_all_order_details_making_completed(order)
      order.update(status: 'shipping_in_process')
    end

    flash[:notice] = "更新に成功しました。"
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def is_all_order_details_making_completed(order)
    
    order.order_details.each do |order_detail|
      if order_detail.making_status != 'making_completed'
        return false
      end
    end
    return true
  end
end