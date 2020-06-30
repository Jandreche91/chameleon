class AddForeingKeyToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :milestone, foreign_key: true
  end
end
