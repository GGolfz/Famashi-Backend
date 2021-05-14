class Medicine < ApplicationRecord
	has_many :reminders, :foreign_key => 'medicines_id'
end
