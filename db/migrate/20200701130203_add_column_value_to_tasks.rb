class AddColumnValueToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :value, :integer
  end
end
