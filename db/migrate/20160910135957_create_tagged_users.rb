class CreateTaggedUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tagged_users do |t|
      t.integer :photo_id
      t.integer :user_id
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height

      t.timestamps
    end

    add_index :tagged_users, :photo_id
    add_index :tagged_users, :user_id
  end
end
