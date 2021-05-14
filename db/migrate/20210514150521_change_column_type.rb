class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :medicines, :medicine_unit, :string
    change_column :medicines, :dosage_unit, :string
  end
end
