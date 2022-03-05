class Team < ApplicationRecord
  has_many :player_seasons
  has_many :players, through: :player_seasons
  belongs_to :league
  validates :name, presence: true, uniqueness: true
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name, :alternate_name ],
    using: {
      tsearch: { prefix: true }
    }
end
