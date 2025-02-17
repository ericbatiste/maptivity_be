class AddSpeedAndElevationColumnsToActivities < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :max_speed, :float
    add_column :activities, :average_speed, :float
    add_column :activities, :climbing, :float
    add_column :activities, :descending, :float
  end
end
