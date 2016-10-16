class AddSizeToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :width, :integer, :default => 0
    add_column :photos, :height, :integer, :default => 0
  end
end
