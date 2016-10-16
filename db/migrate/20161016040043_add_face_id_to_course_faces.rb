class AddFaceIdToCourseFaces < ActiveRecord::Migration[5.0]
  def change
    add_column :course_faces, :face_id, :integer, index: true
    add_index :course_faces, [:course_user_id, :face_id]
  end
end
