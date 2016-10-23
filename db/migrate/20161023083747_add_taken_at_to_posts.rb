class AddTakenAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :taken_at, :datetime, default: "now()"
  end
end