class Team < ApplicationRecord
  has_many :player_seasons
  has_many :players, through: :player_seasons
  belongs_to :league
  validates :name, presence: true, uniqueness: true
end
