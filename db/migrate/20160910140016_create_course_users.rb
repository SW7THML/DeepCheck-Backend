class CreateCourseUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :course_users do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end

    add_index :course_users, :course_id
    add_index :course_users, :user_id
  end
end
