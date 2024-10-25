class SearchDatasController < ApplicationController
  def select; end

  def new
    @search_data = SearchData.new
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

    # 既に取得済みの風の情報を一時的に格納
    @wind_speed = params[:wind_speed]
    @wind_direction = params[:wind_direction]
  end

  def index
    @q = SearchData.ransack(params[:q])
    @search_datas = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @search_data = current_user.search_datas.build(search_data_params)

    if @search_data.save
      redirect_to search_datas_path, notice: "データが保存されました"
    else
      # ここでエラーメッセージをログに出力
      logger.debug @search_data.errors.full_messages.to_sentence
      flash.now[:alert] = "保存に失敗しました: " + @search_data.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def search_data_params
    params.require(:search_data).permit(:location_name, :wind_speed, :wind_direction, :memo)
  end
end
