class Season < ApplicationRecord
  has_many :player_seasons
  has_many :players, through: :player_seasons
  validates :year, presence: true
end
