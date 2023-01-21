class Public::CartItemsController < ApplicationController
    
  def index
    @cart_items=current_user.cart_items
    @total=0
  end
  
  def create
    if CartItem.find_by(item_id: params[:item_id])
      @cart_item=CartItem.find(params[:id])
      @cart_item.order_item_quantity += params[:cart_item][:order_item_quantity].to_i
      @cart_item.save
      redirect_to current_cart
    else
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to current_cart
    end
  end
      
  def update
    @cart_item=CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to current_cart
  end
  
  def destroy
    @cart_item=CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to current_cart
  end
  
  def destroy_all
    current_user.cart_items.destroy_all
    redirect_to current_cart
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :order_item_quantity)
  end

end
