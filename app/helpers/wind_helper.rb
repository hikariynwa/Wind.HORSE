module WindHelper
  def wind_adjusted_angle(degree, base_degree)
    (degree - base_degree) % 360
  end

  # 方角を日本語名で返す
  def wind_direction_with_angle(degree, base_degree)
    adjusted_degree = wind_adjusted_angle(degree, base_degree)

    # 方角と角度の対応リスト
    directions = [
      { name: "北", angle: 0 }, { name: "北北東", angle: 22.5 }, { name: "北東", angle: 45 }, { name: "東北東", angle: 67.5 },
      { name: "東", angle: 90 }, { name: "東南東", angle: 112.5 }, { name: "南東", angle: 135 }, { name: "南南東", angle: 157.5 },
      { name: "南", angle: 180 }, { name: "南南西", angle: 202.5 }, { name: "南西", angle: 225 }, { name: "西南西", angle: 247.5 },
      { name: "西", angle: 270 }, { name: "西北西", angle: 292.5 }, { name: "北西", angle: 315 }, { name: "北北西", angle: 337.5 }
    ]

    # 方角を計算
    index = ((adjusted_degree + 11.25) / 22.5).to_i % 16
    directions[index][:name]
  end
end
