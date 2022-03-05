class TeamsController < ApplicationController

  def search
    if params[:query].present?
      @teams = Teams.where('name ILIKE :query OR alternate_name ILIKE :query', query: "%#{params[:query]}%").limit(3)
    else
      @teams = Team.order(:name).limit(3)
    end

    respond_to do |format|
      format.text { render partial: 'teams/search_card', locals: { teams: @teams }, formats: [:html] }
    end
  end
end
