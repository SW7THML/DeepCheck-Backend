class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :course_id
      t.text :content

      t.timestamps
    end

    add_index :posts, :course_id
  end
end
