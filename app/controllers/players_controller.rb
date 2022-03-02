class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @players = Player.all
  end

  def show
  end
end
