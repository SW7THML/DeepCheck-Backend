class AddOxfordToTaggedUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :tagged_users, :fid, :string, :default => ""
    add_index :tagged_users, :fid
    add_index :tagged_users, [:x, :y, :width, :height]
  end
end
