class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    # @order_detailという注文明細オブジェクトのmaking_status属性を、
    # params[:order_detail][:making_status]の値で更新するコード
    @order_detail.update(making_status: params[:order_detail][:making_status])
    order = @order_detail.order

    # params[:order_detail][:making_status]が特定の値（"in_making"）である場合に、
    # 関連する注文 (order) のステータスを"making"に更新する
    if params[:order_detail][:making_status] == "in_making"
       order.update(status:"making")
    end

    # is_all_order_details_making_completedメソッドがtrueを返す場合に、
    # 注文に紐づいた注文明細がすべて「making_completed」であると判断され、
    # それに基づいて注文のステータスを更新
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


  # 指定された注文 (order) に紐づいた注文明細 (order_detail) が
  # すべて「making_completed」のステータスになっているかどうかを確認するメソッド

  # 指定された注文 (order) を引数として受け取ります
  def is_all_order_details_making_completed(order)
    # 注文に紐づいた注文明細 (order_details) を順番に取り出し、
    # それぞれの注文明細に対してブロック内の処理を実行
    order.order_details.each do |order_detail|
      # 注文明細のmaking_statusが「making_completed」でない場合、
      # つまり「making_completed」でないステータスが見つかった場合、falseを返してメソッドを終了
      if order_detail.making_status != 'making_completed'
        return false
      end
    end
    # 上記のループを抜けた場合、つまりすべての注文明細のmaking_statusが
    # 「making_completed」だった場合、trueを返してメソッドを終了
    return true
  end
end