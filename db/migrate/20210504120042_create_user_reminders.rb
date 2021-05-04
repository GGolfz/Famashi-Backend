class CreateUserReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :user_reminders do |t|
      t.belongs_to :users
      t.integer :type
      t.time :time
    end
  end
end
