class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name
      t.string :postal_code
      t.string :address
      t.string :phone_number
      t.integer :shipping_cost
      t.integer :total_price
      t.integer :payment_method
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
