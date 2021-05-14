class EditReminder < ActiveRecord::Migration[6.1]
  def change
    remove_index :reminders, name: "index_reminders_on_user_reminders_id"
    remove_column :reminders, :user_reminders_id
    add_column :reminders, :time_type, :integer
  end
end
