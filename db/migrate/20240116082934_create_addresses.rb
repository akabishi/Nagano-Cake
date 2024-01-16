class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :customer, foreign_key: true, null: false
      t.string :postal_code
      t.string :address
      t.string :name
      
      t.timestamps
    end
  end
end
