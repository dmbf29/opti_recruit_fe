class Player < ApplicationRecord
  has_many :player_seasons, dependent: :destroy
  validates :short_name, presence: true
  validates :long_name, presence: true
  validates :sofifa_id, presence: true, uniqueness: true

  def age
    return '-' unless dob

    birthday = Date.parse(dob)
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
