class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_detail = Order_item.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    Order.update(order_params)
    @order_detail = Order_item.find(params[:id])
    Order_detail.update(order_detail_params)
    render :show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end

end
