class Admin::OrdersController < ApplicationController
  #注文履歴表示用（ユーザー別）
  def index
    @customer = Customer.find(params[:customer_id])
    # @orders = Order.find(params[:customer_id])
  end

  #注文詳細表示用
  def show
    # @order = Order.find(params[:id])
    # @order_detail = Order_item.find(params[:id])
    # @customer = Customer.find(params[:customer_id])
    # @name = @customer.last_name + "　" + @customer.first_name
    
  end

  def update
    @order = Order.find(params[:id])
    @customer = Customer.find(params[:customer_id])
    if @order.update(order_params)
      render :show, success:"注文ステータスを更新しました"
    else
      render :show
    end
    @order_item = Order_item.find(params[:id])
    if @order_item.update(order_detail_params)
      render :show, detail_success:"制作ステータスを更新しました"
    else
      render :show
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end

end
