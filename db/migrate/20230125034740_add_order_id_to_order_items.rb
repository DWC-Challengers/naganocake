class AddOrderIdToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :order_id, :integer
    add_column :order_items, :item_id, :integer
  end
end
