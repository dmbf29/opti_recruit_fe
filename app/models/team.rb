class Team < ApplicationRecord
  has_many :player_seasons
  has_many :players, -> { distinct }, through: :player_seasons
  belongs_to :league
  validates :name, presence: true, uniqueness: true
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name, :alternate_name ],
    using: {
      tsearch: { prefix: true }
    }
  SKIP_TEAMS = [
    "Chinese Super League",
    "Saudi Abdul L. Jameel League",
    "Japanese J. League Division 1",
    "Croatian Prva HNL",
    "Greek Super League",
    "Czech Republic Gambrinus Liga",
    "Chilian Campeonato Nacional",
    "Australian Hyundai A-League",
    "Norwegian Eliteserien",
    "Danish Superliga",
    "Austrian Football Bundesliga",
    "UAE Arabian Gulf League",
    "Uruguayan Primera División",
    "Paraguayan Primera División",
    "Colombian Liga Postobón",
    "Polish T-Mobile Ekstraklasa",
    "Korean K League 1",
    "Ecuadorian Serie A",
    "South African Premier Division",
    "Romanian Liga I",
    "German 3. Bundesliga",
    "Peruvian Primera División",
    "Finnish Veikkausliiga",
    "Rep. Ireland Airtricity League",
    "Liga de Fútbol Profesional Bolivianqo",
    "Venezuelan Primera División",
    "Hungarian Nemzeti Bajnokság I",
    "Indian Super League",
    "Cypriot First Division"
  ]
end
