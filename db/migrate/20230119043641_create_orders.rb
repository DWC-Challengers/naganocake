class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
    t.integer :payment_method
    t.integer :postage
    t.integer :billing_amount
    t.integer :status
    t.string :address_name
    t.string :postal_code
    t.string :address

      t.timestamps
    end
  end
end
