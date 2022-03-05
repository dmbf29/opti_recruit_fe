class TeamsController < ApplicationController
  skip_before_action :authenticate_user!, only: :search

  def search
    if params[:query].present?
      @teams = Team.where('name ILIKE :query OR alternate_name ILIKE :query', query: "%#{params[:query]}%").limit(3)
    else
      @teams = Team.order(:name).limit(3)
    end

    respond_to do |format|
      format.text { render partial: 'teams/search_card', locals: { teams: @teams }, formats: [:html] }
    end
  end
end
