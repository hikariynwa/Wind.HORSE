require 'httparty'
require 'uri'

class WindData < ApplicationRecord
  include HTTParty
  base_uri 'api.openweathermap.org'

  def initialize(location)
    @api_key = ENV['OPENWEATHERMAP_API_KEY']
    @options = { query: { q: "#{location},jp", appid: @api_key, lang: 'ja' } }

    # リクエスト内容のログ出力
    Rails.logger.info "APIリクエスト: #{@options.inspect}"
  end

  def fetch_wind_data
    # OpenWeather API から風のデータを取得
    response = self.class.get("/data/2.5/weather", @options)

    # APIレスポンスのログ出力
    Rails.logger.info "APIレスポンス: #{response.parsed_response.inspect}"

    if response.success?
      parse_wind_data(response.parsed_response)
    else
      nil
    end
  end

  private

  def parse_wind_data(data)
    {
      wind_speed: data["wind"]["speed"],
      wind_direction: data["wind"]["deg"]
    }
  end
end
