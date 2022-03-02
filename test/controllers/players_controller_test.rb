require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get replacements" do
    get players_replacements_url
    assert_response :success
  end
end
