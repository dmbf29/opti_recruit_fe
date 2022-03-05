class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # @players = Player.includes(:player_seasons).limit(15)
    if params[:team].present?
      @team = Team.search_by_name(params[:team]).first || Team.find_by(name: "Liverpool")
    else
      @team = Team.find_by(id: params[:team_id]) || Team.find_by(name: "Liverpool")
    end
    @players = @team.players.includes(:player_seasons).where.not(name: nil)
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    # @players = Player.includes(:player_seasons).where.not(id: @player).where.not(position: nil).where.not(team: @player.team).limit(10)
    # City.includes(:photos).where(photos: { city_id: nil })
    @players = @player.search(params)
    @positions = Player.pluck(:position).uniq.sort
  end
end
