class Player < ApplicationRecord
  has_many :player_seasons, dependent: :destroy
  validates :short_name, presence: true
  validates :long_name, presence: true
  validates :sofifa_id, presence: true, uniqueness: true
  scope :order_unnamed, -> { includes(:player_seasons).where.not(name: nil).order("player_seasons.value_eur desc") }

  def not_empty
    Player.includes(:player_seasons).where.not(id: self).where.not(position: nil).where.not(player_seasons: { team_id: self.team }).where.not(name: nil)
  end

  def search(params)
    players =
      if params[:position].present? && params[:position] != 'All'
        not_empty.where(position: params[:position])
      else
        not_empty
      end
    players.limit(10)
  end

  def age
    return '-' unless dob

    birthday = Date.parse(dob)
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def team
    last_player_season.team
  end

  def last_player_season
    player_seasons.includes(:season).order("seasons.year desc").last
  end

  def growth_potential
    last_player_season.potential - last_player_season.overall
  end
end
