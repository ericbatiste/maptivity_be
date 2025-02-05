class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :designation
      t.text :notes
      t.datetime :start_time
      t.datetime :end_time
      t.string :route
      t.float :distance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
