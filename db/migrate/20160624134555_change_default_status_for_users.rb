class ChangeDefaultStatusForUsers < ActiveRecord::Migration[4.2]
  def change
        change_column_default(:users, :status, 1)

  end
end
