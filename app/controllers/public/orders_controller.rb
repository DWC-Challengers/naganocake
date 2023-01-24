class Public::OrdersController < ApplicationController
    
    
def new
    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer: current_customer)
end

def index
     @orders = Order.all
end

def show
    @order = Order.find(params[log])
end

def create
     @cart_items = current_customer.cart_items.all
     @order = current_customer.orders.new(order_params)
    if @order.save
         @cart_items.each do |cart|
             order_item = OrderItem.new
             order_item.item_id = cart.item_id
             order_item.order_id = @order.id
             order_item.order_quantity = cart.quantity
             order_item.order_price = cart.item.price
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
end

def thanx
end 
  def order_params
    params.require(:order).permit(:postal_code, :address, :address_name, :payment_method, :billing_amount)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :address_name)
  end
end
