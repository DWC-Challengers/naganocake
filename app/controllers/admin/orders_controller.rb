class Admin::OrdersController < ApplicationController
  #注文履歴表示用（ユーザー別）
  def index
    @customer = Customer.find(params[:customer_id])
    # @orders = Order.find(params[:customer_id])
  end

  #注文詳細表示用
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
