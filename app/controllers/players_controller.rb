class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @team = Team.find_by(id: params[:team_id]) || Team.find_by(name: "Liverpool")
    if params[:position].present?
      # @players = @team.players.order_unnamed.where(position: Player.positions(params[:position]))
      @players = Player.where("name = 'Jadon Sancho' OR name = 'Virgil van Dijk' OR short_name = 'Cristiano Ronaldo'")
    else
      @players = Player.where("name = 'Jadon Sancho' OR name = 'Virgil van Dijk' OR short_name = 'Cristiano Ronaldo'")
    end
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    @positions = Player.pluck(:position).uniq.sort
    # @players = @player.search(params) # without API
    @players = FetchSimilarService.new(
      sofifa_id: @player.sofifa_id,
      position: params[:position].blank? ? 'All' : params[:position],
      params: params
    ).call
    respond_to do |format|
      format.html
      format.text { render partial: 'players/tables', locals: { players: @players }, formats: [:html] }
    end
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
