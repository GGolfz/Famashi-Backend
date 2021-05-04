class CreateMedicines < ActiveRecord::Migration[6.1]
  def change
    create_table :medicines do |t|
      t.belongs_to :users
      t.string :medicine_name
      t.text :description
      t.integer :total_amount
      t.integer :remain_amount
      t.integer :medicine_unit
      t.integer :dosage_amount
      t.integer :dosage_unit
      t.string :medicine_image
      t.string :medicine_leaflet 
      t.timestamps
    end
  end
end
