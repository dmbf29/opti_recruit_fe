class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:team].present?
      @team = Team.search_by_name(params[:team]).first || Team.find_by(name: "Liverpool")
    else
      @team = Team.find_by(id: params[:team_id]) || Team.find_by(name: "Liverpool")
    end
    @players = @team.players.order_unnamed
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    @players = @player.search(params).order_unnamed
    @positions = Player.pluck(:position).uniq.sort
  end
end
