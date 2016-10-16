class CreateCourseFaces < ActiveRecord::Migration[5.0]
  def change
    create_table :course_faces do |t|
      t.integer :course_user_id, index: true
      t.string :fid, default: "", index: true

      t.timestamps
    end
  end
end
