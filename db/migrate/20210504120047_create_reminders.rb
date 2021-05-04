class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.belongs_to :medicines
      t.belongs_to :user_reminders
      t.timestamps
    end
  end
end
