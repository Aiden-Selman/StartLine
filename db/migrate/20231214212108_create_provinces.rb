class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst

      t.timestamps
    end
  end
end
