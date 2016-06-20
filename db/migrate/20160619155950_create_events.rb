class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :text
      t.string :rec_type
      t.integer :event_length
      t.integer :event_pid

      t.timestamps null: false
    end
  end
end
