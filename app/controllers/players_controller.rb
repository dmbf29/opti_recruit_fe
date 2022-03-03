class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @players = Player.includes(:player_seasons).limit(15)
    # @team = Team.find_by(name: "Liverpool")
    # @players = @team.players.includes(:player_seasons)
  end

  def show
    @player = Player.find(params[:id])
    @players = Player.where.not(id: @player).limit(10)
  end
end
