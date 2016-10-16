class AddOriginUrlToFaces < ActiveRecord::Migration[5.0]
  def change
    add_column :faces, :origin_url, :string, default: ""
    add_index :faces, [:user_id, :origin_url]
  end
end
