class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :player_seasons, through: :teams
  has_many :players, through: :player_seasons
  validates :name, presence: true, uniqueness: true
end
