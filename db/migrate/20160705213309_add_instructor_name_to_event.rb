class AddInstructorNameToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :instructor_name, :string
  end
end
