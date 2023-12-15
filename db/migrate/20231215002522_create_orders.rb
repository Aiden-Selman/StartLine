class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :quantity
      t.integer :province_id
      t.decimal :total_price

      t.timestamps
    end
  end
end
