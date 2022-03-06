class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    if params[:team].present?
      @team = Team.search_by_name(params[:team]).first || Team.find_by(name: "Liverpool")
    else
      @team = Team.find_by(id: params[:team_id]) || Team.find_by(name: "Liverpool")
    end
    if params[:position].present?
      @players = @team.players.order_unnamed.where(position: Player.positions(params[:position]))
    else
      @players = @team.players.order_unnamed
    end
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    @players = @player.search(params).order_unnamed
    @positions = Player.pluck(:position).uniq.sort
  end

  def search
    if params[:query].present?
      @players = Player.where('name ILIKE :query OR long_name ILIKE :query OR short_name ILIKE :query', query: "%#{params[:query]}%").limit(3)
    else
      @players = Player.order(:name).limit(3)
    end

    respond_to do |format|
      format.text { render partial: 'players/search_card', locals: { players: @players }, formats: [:html] }
    end
  end
end
