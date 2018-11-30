class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :monday, default: false, null: false
      t.boolean :tuesday, default: false, null: false
      t.boolean :wednesday, default: false, null: false
      t.boolean :thursday, default: false, null: false
      t.boolean :friday, default: false, null: false
      t.boolean :saturday, default: false, null: false
      t.boolean :sunday, default: false, null: false
      t.time :time, null: false

      t.timestamps
    end
  end
end
