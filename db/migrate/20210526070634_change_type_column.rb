class ChangeTypeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :usage_histories, :amount_unit, :string
  end
end
