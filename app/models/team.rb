class Team < ApplicationRecord
  has_many :players
  belongs_to :league
  validates :name, presence: true, uniqueness: true
end
