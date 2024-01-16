class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre_id, foreign_key: true
      t.string :name
      t.text :introduction
      t.integer :price
      t.booleran :is_active, default: true

      t.timestamps
    end
  end
end
