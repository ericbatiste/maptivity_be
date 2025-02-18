class AddCascadeDeletetoActivities < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :activities, :users
    add_foreign_key :activities, :users, on_delete: :cascade
  end
end
