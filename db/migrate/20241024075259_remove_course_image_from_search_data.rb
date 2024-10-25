class RemoveCourseImageFromSearchData < ActiveRecord::Migration[7.2]
  def change
    remove_column :search_data, :course_image, :string
  end
end
