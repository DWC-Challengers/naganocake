class Public::CartItemsController < ApplicationController
    
  def index
    @cart_items=CartItem.all
    @total=0
  end
  
  def create
    if CartItem.find_by(item_id: params[:item_id])
      @cart_item=CartItem.find(params[:id])
      @cart_item.order_item_quantity += params[:cart_item][:order_item_quantity].to_i
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path
    end
  end
      
  def update
    @cart_item=CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item=CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    current_user.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :order_item_quantity)
  end

end
