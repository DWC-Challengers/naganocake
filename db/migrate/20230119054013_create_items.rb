class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genres_id
      t.string  :name
      t.text    :text
      t.integer :non_taxed_price
      t.boolean :is_active

      t.timestamps
    end
  end
end
