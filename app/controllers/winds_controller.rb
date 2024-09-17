# gem httpartyを読み込む
require "httparty"
# URIモジュールを読み込む（URLのエンコードや解析に使われる）
require "uri"

class WindsController < ApplicationController
  before_action :validate_location, only: [ :show ]

  def show
    location = params[:id] # params[:location]ではなくparams[:id]

    response = WindsService.new(location).fetch_wind

    if response.success?
      wind_data = response.parsed_response
      @wind = {
        wind_speed: wind_data["wind"]["speed"],
        wind_direction: wind_direction(wind_data["wind"]["deg"])
      }

      render json: @wind
    else
      render json: { error: "風の情報を取得できませんでした。" }, status: :unprocessable_entity
    end
  end

  private

  def validate_location
    render json: { error: "場所を入力してください。" }, status: :bad_request if params[:id].blank?
  end

  def wind_direction(degree)
    directions = [ "北", "北北東", "北東", "東北東", "東", "東南東", "南東", "南南東", "南", "南南西", "南西", "西南西", "西", "西北西", "北西", "北北西" ]
    index = ((degree + 11.25) / 22.5).to_i % 16
    directions[index]
  end
end


class WindsService
  # HTTPartyモジュールをWindServiceクラスにインクルード
  include HTTParty
  # OpenWeatherMap APIのベースURIを設定
  base_uri "api.openweathermap.org"

  def initialize(location)
    # 環境変数からOpenWeatherMapのAPIキーを取得
    api_key = ENV["OPENWEATHERMAP_API_KEY"]
    # APIリクエストのためのオプションを設定
    @options = { query: { q: "#{location},jp", appid: api_key, lang: "ja" } }
  end

  def fetch_wind
    response = self.class.get("/data/2.5/weather", @options)

    # APIレスポンスのログ出力
    Rails.logger.info "APIレスポンス: #{response.body}"

    response
  end
end
