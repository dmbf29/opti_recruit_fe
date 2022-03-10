class FetchSimilarService
  attr_reader :url, :sofifa_id, :age_min, :age_max, :value_min, :value_max, :position, :params

  def initialize(attrs = {})
    @base_url = ''
    @sofifa_id = attrs[:sofifa_id]
    @params = attrs[:params]
    @age_min = params[:age_min].any? ? params[:age_min] : 0
    @age_max = params[:age_max].any? ? params[:age_max] : 99
    @value_min = params[:value_min].any? ? params[:value_min] : 0
    @value_max = params[:value_max].any? ? params[:value_max] : 999_999_999
    @position = params[:position]
    @url = "#{@base_url}/similarities?player_id=#{sofifa_id}&age_min=#{age_min}age_max=#{age_max}&value_min=#{value_min}&value_max=#{value_max}&position=#{position}"
  end

  def call
    response = HTTParty.get(url).body
    players = JSON.parse(response)
    players.map do |player|
      player = Player.find_by(sofifa_id: player['sofifa_id'])
      player.match = player['score']
    end
  end
end
