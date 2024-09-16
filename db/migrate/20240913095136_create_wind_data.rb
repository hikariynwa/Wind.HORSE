class CreateWindData < ActiveRecord::Migration[7.2]
  def change
    create_table :wind_data do |t|
      t.float :wind_speed  # 風速を保存するカラム
      t.integer :wind_direction  # 風向きを保存するカラム

      t.timestamps
    end
  end
end
