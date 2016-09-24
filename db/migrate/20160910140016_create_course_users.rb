class CreateCourseUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :course_users do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end

    add_index :course_users, [:course_id, :user_id], :unique => true
  end
end
