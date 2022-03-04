class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # @players = Player.includes(:player_seasons).limit(15)
    @team = Team.find_by(name: "Manchester United")
    @players = @team.players.includes(:player_seasons)
  end

  def show
    @player = Player.find(params[:id])
    @players = Player.where.not(id: @player).where.not(position: nil).where.not(team: @player.team).limit(10)
    raise
  end
end
