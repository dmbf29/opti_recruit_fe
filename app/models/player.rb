class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :player_seasons, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def age
    27
  end
end
