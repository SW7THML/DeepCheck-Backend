class SetDefaultAsNilOfPosts < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:posts, :taken_at, nil)
  end
end
