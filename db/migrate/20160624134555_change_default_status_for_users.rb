class ChangeDefaultStatusForUsers < ActiveRecord::Migration
  def change
        change_column_default(:users, :status, 1)

  end
end
