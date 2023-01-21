class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.string :order_item_quantity
      t.timestamps
    end
  end
end
