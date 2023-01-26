class Public::OrdersController < ApplicationController
    
    
def new
    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer: current_customer)
end

def index
     @orders = Order.all
     
end

def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
end

def create
     cart_items = current_customer.cart_items.all
     @order = current_customer.orders.new(order_params)
    if @order.save
         cart_items.each do |cart|
             order_item = OrderItem.new
             order_item.item_id = cart.item_id
             order_item.order_id = @order.id
             order_item.quantity = cart.order_item_quantity
             order_item.tax_included_price = cart.item.non_taxed_price
             order_item.save
         end
     redirect_to "/orders/thanx"
     cart_items.destroy_all
    else
     @order = Order.new(order_params)
     render :new
    end
end 

def log 
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.address_name        = current_customer.last_name +
                           current_customer.first_name
    elsif params[:order][:address_number] == "2"
      ship = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.address_name        = ship.address_name
     
    elsif params[:order][:address_number] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.address_name        = params[:order][:address_name]
    
    else
            render 'new'

    end
    
  @cart_items = current_customer.cart_items.all 
 

end


def thanx
end 

private

  def order_params
    params.require(:order).permit(:address, :address_name, :payment_method,:postal_code,:billing_amount,:status)
  end

  def shipping_address_params
    params.require(:order).permit(:postal_code, :address, :address_name,:address_number, :shipping_address_id,)
  end
end
