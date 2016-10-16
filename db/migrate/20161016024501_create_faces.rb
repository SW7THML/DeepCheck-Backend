class CreateFaces < ActiveRecord::Migration[5.0]
  def change
    create_table :faces do |t|
      t.integer :user_id, index: true
      t.string :attachment

      t.timestamps
    end
  end
end
