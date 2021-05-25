class AddTimetype < ActiveRecord::Migration[6.1]
  def change
    add_column :usage_histories, :time_type, :int
  end
end
