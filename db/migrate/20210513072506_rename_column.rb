class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_reminders, :type, :time_type
  end
end
