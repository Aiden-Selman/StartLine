class AddPriceToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :price, :decimal
  end
end
