class CartItem < ApplicationRecord
    
  belongs_to :customer, optional: true
  belongs_to :item, optional: true
  
  validates :order_item_quantity, presence: true, numericality: {only_integer: true}
  
  def subtotal
    item.with_tax_price*order_item_quantity.to_i
  end
    
end
