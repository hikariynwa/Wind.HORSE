class SearchDatasController < ApplicationController
  def select; end

  def new
    # data-value属性の値がまずここに入る。
    location = params[:location]

    # ローマ字名称を日本語に変換
    location_mapping = {
      "Fuchu" => "東京",
      "Fushimi" => "京都",
      "Niigata" => "新潟"
    }

    @location_name = location_mapping[location]

    @course_image = "#{location.downcase}_course.png"

    # 競馬場ごとの方位画像の回転角度を設定
    course_rotation_mapping = {
      "Fuchu" => "180deg",
      "Fushimi" => "45deg",
      "Niigata" => "135deg"
    }

    # 回転角度を変数に格納
    @course_rotation = course_rotation_mapping[location]
  end
end
