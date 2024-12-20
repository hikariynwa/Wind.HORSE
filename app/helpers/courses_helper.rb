module CoursesHelper
  COURSE_ROTATION_MAPPING = {
    "Fuchu" => "180deg",
    "Fushimi" => "215deg",
    "Niigata" => "210deg",
    "Funabashi" => "255deg"
  }.freeze

  LOCATION_MAPPING = {
    "東京" => "Fuchu",
    "京都" => "Fushimi",
    "新潟" => "Niigata",
    "中山" => "Funabashi"
  }.freeze

  COURSE_BASE_DEGREE_MAPPING = {
    "Fuchu" => 180,
    "Fushimi" => 215,
    "Niigata" => 210,
    "Funabashi" => 255
  }.freeze

  def rotation_for_course(location)
    COURSE_ROTATION_MAPPING[location]
  end

  def base_degree_for(location)
    COURSE_BASE_DEGREE_MAPPING[location]
  end

  # 日本語の競馬場名を英語に変換
  def english_location_for(japanese_name)
    LOCATION_MAPPING[japanese_name]
  end
end
