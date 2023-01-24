class ShippingAddress < ApplicationRecord
    belongs_to :customer, optional: true
    
    validates :postal_code, presence: true, numericality: { only_integer: true }, length: {is: 7}
    validates :address, presence: true, length: {maximum: 80}
    validates :address_name, presence: true, length: {maximum: 40}
    
end
