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
  end
end
