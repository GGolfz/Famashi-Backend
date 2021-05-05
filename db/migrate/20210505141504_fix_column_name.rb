class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :allergies, :machine_name, :medicine_name
  end
end
