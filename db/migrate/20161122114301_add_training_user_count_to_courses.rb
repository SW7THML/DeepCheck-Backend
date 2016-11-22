class AddTrainingUserCountToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :training_user_count, :integer, :default => 0
  end
end
