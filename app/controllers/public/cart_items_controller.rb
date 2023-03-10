class Public::CartItemsController < ApplicationController
  before_action :is_matching_login_customer, only: [:index, :create, :update, :destroy, :destroy_all]
    
  def index
    @cart_items=current_customer.cart_items
    @total=@cart_items.inject(0){ |total, item| total + item.subtotal }
  end
  
  def create
    if CartItem.find_by(item_id: params[:cart_item][:item_id])
      @cart_item=current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item_add=CartItem.new(cart_item_params)
      new_quantity = @cart_item.order_item_quantity.to_i + @cart_item_add.order_item_quantity.to_i
      @cart_item.update_attribute(:order_item_quantity, new_quantity)
      redirect_to cart_items_path
    elsif params[:cart_item][:order_item_quantity] =~ /^[0-9]+$/
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.customer_id=current_customer.id
      @cart_item.save
      redirect_to cart_items_path
    else
      flash[:notice] = "個数を選択してください"
      redirect_to request.referer
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
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :order_item_quantity)
  end
  
  def is_matching_login_customer
    unless customer_signed_in?
      redirect_to root_path
    end
  end

end
