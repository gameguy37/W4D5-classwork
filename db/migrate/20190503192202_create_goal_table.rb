class CreateGoalTable < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.boolean :completed, default: false
      t.text :body, null: false
      t.string :privacy, null: false
      t.string :title, null: false
    end

    add_index :goals, :user_id
  end
end
