class ChangeDefaultValueToPosts < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :taken_at, :date
    change_column_default :posts, :taken_at, ''
  end
end
