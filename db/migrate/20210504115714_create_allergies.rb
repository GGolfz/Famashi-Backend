class CreateAllergies < ActiveRecord::Migration[6.1]
  def change
    create_table :allergies do |t|
      t.belongs_to :users
      t.string :machine_name
      t.string :side_effect
      t.timestamps
    end
  end
end
