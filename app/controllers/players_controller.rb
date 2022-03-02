class PlayersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :replacement]

  def index
  end

  def replacement
  end
end
