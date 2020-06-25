class CreateMilestones < ActiveRecord::Migration[6.0]
  def change
    create_table :milestones do |t|
      t.boolean :done, default: false
      t.string :description
      t.date :end_date
      t.integer :progress_rate
      t.references :project

      t.timestamps
    end
  end
end
