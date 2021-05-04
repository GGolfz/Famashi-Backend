class CreateUsageHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :usage_histories do |t|
      t.belongs_to :users
      t.belongs_to :medicines
      t.integer :amount
      t.integer :amount_unit
      t.date :date
      t.time :time
      t.timestamps
    end
  end
end
