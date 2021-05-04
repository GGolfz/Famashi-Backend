class CreateUserInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :user_infos do |t|
      t.belongs_to :users
      t.column :gender, :integer, default: 0
      t.date :birthdate
      t.float :weight
      t.float :height
      t.boolean :isG6PD
      t.boolean :isLiver
      t.boolean :isKidney
      t.boolean :isGastritis
      t.boolean :isBreastfeeding
      t.boolean :isPregnant
      t.timestamps
    end
  end
end
