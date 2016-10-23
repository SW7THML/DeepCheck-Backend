class AddStatusToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :status, :integer, :default => 0
    add_column :msg, :status, :string, :default => ""
  end
end
