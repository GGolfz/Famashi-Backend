class RefernceNotify < ActiveRecord::Migration[6.1]
  def change
    add_reference :reminders, :user_reminders, foreign_key: true
    remove_column :reminders, :time_type
  end
end
