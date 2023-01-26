class Admin::OrderDetailsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_detail_params)
    if @order_item.status == "in_production"
      @order.update(status:"making")
    elsif @order.order_items.count == @order.order_items.where(status: "complete").count
      @order.update(status:"preparing_delivery")
    end
      redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_item).permit(:status)
  end

end
