class AddColumnHourlyRateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hourly_rate, :integer
  end
end
