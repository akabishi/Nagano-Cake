class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :price
      t.integer :amount
      t.integer :making_status, default: 0
      t.timestamps
    end
  end
end
