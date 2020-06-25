class CreateAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :alerts do |t|
      t.references :project
      t.string :description
      t.boolean :done, default: false
      t.timestamps
    end
  end
end
