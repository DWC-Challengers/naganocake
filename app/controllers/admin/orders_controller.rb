class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  #注文履歴表示用（ユーザー別）
  
  def index
    @customer = Customer.find(params[:customer_id])
    @orders = Order.where(customer_id: params[:customer_id]).page(params[:page])
  end

  #注文詳細表示用
  def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: params[:id])
    # @customer = Customer.find(params[:order][:customer_id])
    
  end

  def update
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirm"
        @order_item.update_all(status: "in_production") 
      end
    end
      # @order = Order.find(params[:id])
      # @order_item = OrderItem.where(order_id: params[:id])
    redirect_to request.referer
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order_item).permit(:status)
  end

end
