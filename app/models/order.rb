class Order < ApplicationRecord
belongs_to :customer
has_many :order_items, dependent: :destroy
    
enum payment_method: { credit_card: 0, transfer: 1 }
enum status: { waiting_payment: 0, payment_confirm: 1,making: 2,preparing_delivery: 3,delivered: 4}

def self.looks(order_status)
  if order_status == 'waiting_payment'
    @order_status = Order.where(status: 'waiting_payment')
  elsif order_status == 'payment_confirm'
    @order_status = Order.where(status: 'payment_confirm')
  elsif order_status == 'making'
    @order_status = Order.where(status: 'making')
  elsif order_status == 'preparing_delivery'
    @order_status = Order.where(status: 'preparing_delivery')
  elsif order_status == 'delivered'
    @order_status = Order.where(status: 'delivered')
  else
    @order_status = Order.all
  end
end 

end
