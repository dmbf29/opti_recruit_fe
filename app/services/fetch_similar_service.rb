class FetchSimilarService
  attr_reader :url, :sofifa_id, :age_min, :age_max, :value_min, :value_max, :position, :params

  def initialize(attrs = {})
    @base_url = ''
    @sofifa_id = attrs[:sofifa_id]
    @params = attrs[:params]
    @age_min = params[:age_min] || 0
    @age_max = params[:age_max] || 99
    @value_min = params[:value_min] || 0
    @value_max = params[:value_max] || 999_999_999
    @position = params[:position]
    @url = "#{@base_url}/similarities?player_id=#{sofifa_id}&age_min=#{age_min}age_max=#{age_max}&value_min=#{value_min}&value_max=#{value_max}&position=#{position}"
  end

  def call
    response = HTTParty.get(url).body
    p JSON.parse(response)
  end
end
