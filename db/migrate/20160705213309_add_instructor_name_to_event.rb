class AddInstructorNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :instructor_name, :string
  end
end
