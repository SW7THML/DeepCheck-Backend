class ChangeTagXy < ActiveRecord::Migration[5.0]
  def change
    change_column :tagged_users, :x,  :float
    change_column :tagged_users, :y,  :float
  end
end
