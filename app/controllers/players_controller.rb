class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # @players = Player.includes(:player_seasons).limit(15)
    @team = Team.find_by(id: params[:team_id]) || Team.find_by(name: "Liverpool")
    @players = @team.players.includes(:player_seasons)
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    # @players = Player.includes(:player_seasons).where.not(id: @player).where.not(position: nil).where.not(team: @player.team).limit(10)
    # City.includes(:photos).where(photos: { city_id: nil })
    @players = Player.includes(:player_seasons).where.not(id: @player).where.not(position: nil).where.not(player_seasons: { team_id: @player.team }).limit(10)
  end
end
