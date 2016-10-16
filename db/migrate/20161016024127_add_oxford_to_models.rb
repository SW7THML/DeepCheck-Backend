class AddOxfordToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :course_users, :uid, :string, :default => ""
    add_column :courses, :gid, :string, :default => ""
    add_index :course_users, :uid
    add_index :courses, :gid
    add_column :courses, :attachment, :string
  end
end
