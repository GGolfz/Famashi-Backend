class RemoveDosageUnit < ActiveRecord::Migration[6.1]
  def change
    remove_column :medicines, :dosage_unit
  end
end
