class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :platform_id
      t.string :genre_id
      t.string :game_name
      t.string :rating
      t.string :release_date

      t.timestamps
    end
  end
end
