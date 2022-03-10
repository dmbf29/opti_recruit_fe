class FetchSimilarService
  attr_reader :url, :sofifa_id, :age_min, :age_max, :value_min, :value_max, :position, :params

  def initialize(attrs = {})
    @base_url = 'https://optirecruitimage-cdv64b7nfq-an.a.run.app'
    @sofifa_id = attrs[:sofifa_id]
    @params = attrs[:params]
    @position = attrs[:position]
    @age_min = params[:age_min].blank? ? 0 : params[:age_min]
    @age_max = params[:age_max].blank? ? 99 : params[:age_max]
    @value_min = params[:value_min].blank? ? 0 : params[:value_min]
    @value_max = params[:value_max].blank? ? 999_999_999 : params[:value_max]
    @url = "#{@base_url}/similarities?player_id=#{sofifa_id}&age_min=#{age_min}&age_max=#{age_max}&value_min=#{value_min}&value_max=#{value_max}&position=#{position}"
  end

  def call
    response = HTTParty.get(url).body
    players = JSON.parse(response)
    players.map do |hash|
      player = Player.find_by(sofifa_id: hash['sofifa_id'])
      player.match = hash['score']
      player
    end
  end
end
