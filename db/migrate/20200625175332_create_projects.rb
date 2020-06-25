class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|

      t.text :description
      t.date :estimated_start_date
      t.date :estimated_end_date
      t.integer :estimated_cost
      t.timestamps
    end
  end
end
