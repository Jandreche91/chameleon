class RemoveColumnActiveFromAssignments < ActiveRecord::Migration[6.0]
  def change
    remove_column :assignments, :active
  end
end
