class FetchProjectedService
  attr_reader :url
  def initialize(attr = {})
    @url = ''
  end

  def call
    response = HTTParty.get(url).body
    p JSON.parse(response)
  end
end
