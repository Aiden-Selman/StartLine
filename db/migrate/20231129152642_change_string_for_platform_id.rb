class ChangeStringForPlatformId < ActiveRecord::Migration[7.0]
  def change
    change_table :games do |t|
      t.change :platform_id, :integer
      t.change :genre_id, :integer
    end
  end
end
