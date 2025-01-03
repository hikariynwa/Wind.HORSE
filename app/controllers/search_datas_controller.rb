class SearchDatasController < ApplicationController
  include CoursesHelper

  before_action :authenticate_user!, except: [ :new, :select ]

  def select
    @error_message = params[:error]
  end

  def new
    @search_data = SearchData.new
    # data-value属性の値がまずここに入る。
    location = params[:location]

    if params[:location].blank?
      flash.now[:alert] = "競馬場を選択してください"
      render :select # selectアクションのビューを表示する
      return
    end

    @location_name = location

    @course_image = "#{location.downcase}_course.png"

    @course_rotation = rotation_for_course(location)

    @wind_speed = params[:wind_speed]
    @wind_direction = params[:wind_direction]
  end

  def index
    if params[:q] && params[:q][:location_name_cont].present?
      location_name_map = {
        "東京" => "Fuchu",
        "京都" => "Fushimi",
        "新潟" => "Niigata",
        "中山" => "Funabashi"
      }
      params[:q][:location_name_cont] = location_name_map[params[:q][:location_name_cont]]
    end

    @q = current_user.search_datas.ransack(params[:q])
    @search_datas = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(8)
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

  def show
    @search_data = SearchData.find(params[:id])
    location = @search_data.location_name

    english_location = english_location_for(location)

    @course_image = "#{location.downcase}_course.png"

    @course_rotation = rotation_for_course(location)

    respond_to do |format|
      format.turbo_stream
      format.html # HTMLでの表示が必要な場合のフォールバック
    end

    @wind_speed = params[:wind_speed]
    @wind_direction = params[:wind_direction]
  end

  def edit
    @search_data = current_user.search_datas.find(params[:id])
    location = @search_data.location_name

    english_location = english_location_for(location)

    @course_image = "#{location.downcase}_course.png"

    @course_rotation = rotation_for_course(location)

    respond_to do |format|
      format.turbo_stream
      format.html # HTMLでの表示が必要な場合のフォールバック
    end

    @wind_speed = params[:wind_speed]
    @wind_direction = params[:wind_direction]
  end

  def update
    @search_data = current_user.search_datas.find(params[:id])
    if @search_data.update(search_data_params)
      redirect_to search_data_path(@search_data), notice: "データが正常に更新されました。"
    else
      render :edit, alert: "データの更新に失敗しました。", status: :see_other
    end
  end

  def destroy
    @search_data = current_user.search_datas.find(params[:id])
    @search_data.destroy
    redirect_to search_datas_path, status: :see_other, success: t("views.notices.search_data_destroyed_destroyed")
  end

  private

  def search_data_params
    params.require(:search_data).permit(:location_name, :wind_speed, :wind_direction, :memo)
  end
end
