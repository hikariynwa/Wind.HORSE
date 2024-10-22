class CreateSearchData < ActiveRecord::Migration[7.2]
  def change
    create_table :search_data do |t|
      t.string :location_name
      t.string :course_image
      t.float :wind_speed
      t.string :wind_direction
      t.text :memo

      t.timestamps
    end
  end
end
