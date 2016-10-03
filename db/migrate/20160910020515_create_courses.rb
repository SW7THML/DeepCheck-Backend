class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :short_link
      t.integer :manager_id

      t.timestamps
    end

    add_index :courses, :manager_id
  end
end
