class Player < ApplicationRecord
  has_many :player_seasons, dependent: :destroy
  validates :short_name, presence: true
  validates :long_name, presence: true
  validates :sofifa_id, presence: true, uniqueness: true
  scope :order_unnamed, -> { includes(:player_seasons).where.not(name: nil).order("player_seasons.value_eur desc") }
  scope :for_age_range, -> min, max { where("date_part('year', age(dob)) >= ? AND date_part('year', age(dob)) <= ?", min, max) }
  scope :for_age_min, -> min { where("date_part('year', age(dob)) >= ?", min) }
  scope :for_age_max, -> max { where("date_part('year', age(dob)) <= ?", max) }

  def not_empty
    Player.includes(:player_seasons).where.not(id: self).where.not(position: nil).where.not(player_seasons: { team_id: self.team }).where.not(name: nil)
  end

  def search(params)
    players =
      if params[:position].present? && params[:age_min].present? && params[:age_max].present? && params[:value_min].present? && params[:value_max].present?
        not_empty.only_position(params).age_min(params).age_max(params).value_min(params).value_max(params)
      elsif params[:position].present? && params[:age_min].present? && params[:age_max].present? && params[:value_min].present?
        not_empty.only_position(params).age_min(params).age_max(params).value_min(params)
      elsif params[:position].present? && params[:age_min].present? && params[:age_max].present? && params[:value_max].present?
        not_empty.only_position(params).age_min(params).age_max(params).value_max(params)
      elsif params[:position].present? && params[:age_min].present? && params[:value_min].present? && params[:value_max].present?
        not_empty.only_position(params).age_min(params).value_min(params).value_max(params)
      elsif params[:position].present? && params[:age_max].present? && params[:value_min].present? && params[:value_max].present?
        not_empty.only_position(params).age_max(params).value_min(params).value_max(params)
      elsif params[:age_min].present? && params[:age_max].present? && params[:value_min].present? && params[:value_max].present?
        not_empty.age_min(params).age_max(params).value_min(params).value_max(params)
      elsif params[:position].present? && params[:age_min].present? && params[:age_max].present?
        not_empty.only_position(params).age_min(params).age_max(params)
      elsif params[:position].present? && params[:value_min].present? && params[:value_max].present?
        not_empty.only_position(params).value_min(params).value_max(params)
      elsif params[:position].present? && params[:age_min].present?
        not_empty.only_position(params).age_min(params)
      elsif params[:position].present? && params[:age_max].present?
        not_empty.only_position(params).age_max(params)
      elsif params[:position].present? && params[:value_min].present?
        not_empty.only_position(params).value_min(params)
      elsif params[:position].present? && params[:value_max].present?
        not_empty.only_position(params).value_max(params)
      elsif params[:age_min].present? && params[:age_max].present?
        not_empty.age_min(params).age_max(params)
      elsif params[:age_min].present? && params[:value_max].present?
        not_empty.age_min(params).value_max(params)
      elsif params[:age_min].present? && params[:value_min].present?
        not_empty.age_min(params).value_min(params)
      elsif params[:age_max].present? && params[:value_max].present?
        not_empty.age_max(params).value_max(params)
      elsif params[:age_max].present? && params[:value_min].present?
        not_empty.value_min(params).age_max(params)
      elsif params[:value_min].present? && params[:value_max].present?
        not_empty.value_min(params).value_max(params)
      elsif params[:position].present?
        not_empty.where(position: params[:position])
      elsif params[:age_min].present?
        not_empty.age_min(params)
      elsif params[:age_max].present?
        not_empty.age_max(params)
      elsif params[:value_min].present?
        not_empty.value_min(params)
      elsif params[:value_max].present?
        not_empty.value_max(params)
      else
        not_empty
      end
    players.limit(10)
  end

  def self.age_min(params)
    where("date_part('year', age(dob)) >= ?", params[:age_min])
  end

  def self.age_max(params)
    where("date_part('year', age(dob)) <= ?", params[:age_max])
  end

  def self.value_min(params)
    where('player_seasons.value_eur >= ?', params[:value_min].to_i)
  end

  def self.value_max(params)
    where('player_seasons.value_eur <= ?', params[:value_max].to_i)
  end

  def self.only_position(params)
    where(position: params[:position])
  end

  def age
    return '-' unless dob

    # now = Time.now.utc.to_date
    # now.year - dob.year - (dob.to_date.change(year: now.year) > now ? 1 : 0)
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
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

  def self.fw
    ['LW', 'ST', 'CF', 'RW']
  end

  def self.mf
    ["LM", "CAM", "CDM", "CM", "RM"]
  end

  def self.df
    ["CB", "LB", "RB", "LWB", "RWB"]
  end

  def self.gk
    ['GK']
  end

  def self.positions(position)
    case position
    when 'FW' then fw
    when 'MF' then mf
    when 'DF' then df
    when 'GK' then gk
    end
  end
end
