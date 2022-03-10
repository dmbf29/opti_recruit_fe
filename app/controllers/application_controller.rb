class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_season

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def set_season
    @season = Season.find_by(year: '2022')
  end
end
