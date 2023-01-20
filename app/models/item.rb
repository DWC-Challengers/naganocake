class Item < ApplicationRecord
  has_many :cart_item
  has_many :order_item
  belongs_to :genre
  
  def add_tax_non_taxed_price
    (self.non_taxed_price * 1.10).round    
  end
  
end
