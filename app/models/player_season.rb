class PlayerSeason < ApplicationRecord
  belongs_to :player
  belongs_to :season
  belongs_to :team
  validates :season, uniqueness: { scope: :player }
end
