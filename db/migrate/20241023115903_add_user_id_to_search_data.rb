class AddUserIdToSearchData < ActiveRecord::Migration[7.2]
  def change
    add_column :search_data, :user_id, :integer
  end
end
