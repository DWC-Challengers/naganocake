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
    @order.name = current_customer.name
    @order.address = current_customer.customer_address
    
    elsif params[:order][:address_number] == "2"
    if Address.exists?(name: params[:order][:shipping_address_id])
     @order.name = Address.find(params[:order][:shipping_address_id]).name
      @order.address = Address.find(params[:order][:shipping_address_id]).address
    else
      render :new
    end
     
    elsif params[:order][:address_number] == "3"
    address_new = current_customer.addresses.new(address_params)
    if address_new.save 
    else
      render :new
    end
    else
    redirect_to "/orders"
    end
  @cart_items = current_customer.cart_items.all 
  @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }

end


def thanx
end 

private

  def order_params
    params.require(:order).permit(:address, :address_name, :payment_method)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :address_name)
  end
end
