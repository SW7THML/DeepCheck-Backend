class ChangeTagXy < ActiveRecord::Migration[5.0]
  def up
    change_column :tagged_users, :x, :float
    change_column :tagged_users, :y, :float
  end

  def down
    change_column :tagged_users, :x, :integer
    change_column :tagged_users, :y, :integer
  end
end
