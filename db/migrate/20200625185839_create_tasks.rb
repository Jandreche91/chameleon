class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user
      t.integer :hours_spent
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
