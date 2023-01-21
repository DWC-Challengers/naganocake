class OrderItem < ApplicationRecord
belongs_to :order
#belongs_to :item
    
    
enum status:{ not_possible: 0,pending: 1,in_production: 2,complete: 3}
end
