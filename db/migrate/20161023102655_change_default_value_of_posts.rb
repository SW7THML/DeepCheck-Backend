class ChangeDefaultValueOfPosts < ActiveRecord::Migration[5.0]
  def change
    change_column_default :posts, :taken_at, 'now()'
  end
end
