class AddShortLinkToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :short_link, :string
  end
end
