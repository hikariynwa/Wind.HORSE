class CoursesController < ApplicationController
  def show
    location = params[:location]
    course_option = params[:course_option]

    Rails.logger.debug("Params location: #{location.inspect}")
    Rails.logger.debug("Course option: #{course_option.inspect}")


    location_mapping = {
      "東京" => "Fuchu",
      "京都" => "Fushimi",
      "新潟" => "Niigata"
    }
    english_location = location_mapping[location] || location


    # コース名に基づいて、対応する画像を設定
    case course_option
    when "芝 1000m"
      @course_image = "#{english_location.downcase}_turf_course_1000.png"
    when "芝 1200m"
      @course_image = "#{english_location.downcase}_turf_course_1200.png"
    when "芝 1400m"
      @course_image = "#{english_location.downcase}_turf_course_1400.png"
    when "芝 1400m内"
      @course_image = "#{english_location.downcase}_turf_course_1400内.png"
    when "芝 1400m外"
      @course_image = "#{english_location.downcase}_turf_course_1400外.png"
    when "芝 1600m"
      @course_image = "#{english_location.downcase}_turf_course_1600.png"
    when "芝 1600m内"
      @course_image = "#{english_location.downcase}_turf_course_1600内.png"
    when "芝 1600m外"
      @course_image = "#{english_location.downcase}_turf_course_1600外.png"
    when "芝 1800m"
      @course_image = "#{english_location.downcase}_turf_course_1800.png"
    when "芝 2000m"
      @course_image = "#{english_location.downcase}_turf_course_2000.png"
    when "芝 2000m内"
      @course_image = "#{english_location.downcase}_turf_course_2000内.png"
    when "芝 2000m外"
      @course_image = "#{english_location.downcase}_turf_course_2000外.png"
    when "芝 2200m"
      @course_image = "#{english_location.downcase}_turf_course_2200.png"
    when "芝 2300m"
      @course_image = "#{english_location.downcase}_turf_course_2300.png"
    when "芝 2400m"
      @course_image = "#{english_location.downcase}_turf_course_2400.png"
    when "芝 2500m"
      @course_image = "#{english_location.downcase}_turf_course_2500.png"
    when "芝 3000m"
      @course_image = "#{english_location.downcase}_turf_course_3000.png"
    when "芝 3200m"
      @course_image = "#{english_location.downcase}_turf_course_3200.png"
    when "芝 3400m"
      @course_image = "#{english_location.downcase}_turf_course_3400.png"
    when "砂 1000m"
      @course_image = "#{english_location.downcase}_dirt_course_1000.png"
    when "砂 1200m"
      @course_image = "#{english_location.downcase}_dirt_course_1200.png"
    when "砂 1300m"
      @course_image = "#{english_location.downcase}_dirt_course_1300.png"
    when "砂 1400m"
      @course_image = "#{english_location.downcase}_dirt_course_1400.png"
    when "砂 1600m"
      @course_image = "#{english_location.downcase}_dirt_course_1600.png"
    when "砂 1800m"
      @course_image = "#{english_location.downcase}_dirt_course_1800.png"
    when "砂 1900m"
      @course_image = "#{english_location.downcase}_dirt_course_1900.png"
    when "砂 2100m"
      @course_image = "#{english_location.downcase}_dirt_course_2100.png"
    when "砂 2400m"
      @course_image = "#{english_location.downcase}_dirt_course_2400.png"
    when "砂 2500m"
      @course_image = "#{english_location.downcase}_dirt_course_2500.png"
    else
      @course_image = "default_course.png"
    end

    # 競馬場ごとの方位画像の回転角度を設定
    course_rotation_mapping = {
      "Fuchu" => "180deg",
      "Fushimi" => "45deg",
      "Niigata" => "135deg"
    }
    @course_rotation = course_rotation_mapping[location]

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end
end
