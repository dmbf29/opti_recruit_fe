class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :player_seasons, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def age
    return '-' unless dob

    birthday = Date.parse(dob)
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
