namespace :player_season do
  desc "Adds player seasons from Fifa Dataset"
  task update_all: :environment do
    years = [21, 22]

    puts "Updating Players..."
    years.each do |year|
      filepath = "db/raw_data/players_#{year}.csv"
      next unless File.exist?(filepath)

      season = Season.find_by(year: "20#{year}")

      puts "opening #{filepath}..."
      CSV.foreach(filepath, headers: :first_row) do |row|
        next if Team::SKIP_TEAMS.include?(row['league_name'])

        player = Player.find_by(sofifa_id: row['sofifa_id'])

        PlayerSeason.where(
          team: Team.find_by(name: row['club_name']),
          player: player,
          season: season,
          overall: row['overall'],
          potential: row['potential'],
          value_eur: row['value_eur'],
          wage_eur: row['wage_eur'],
          international_reputation: row['international_reputation'],
          release_cause_eur: row['release_cause_eur'],
          pace: row['pace'],
          shooting: row['shooting'],
          passing: row['passing'],
          dribbling: row['dribbling'],
          defending: row['defending'],
          physic: row['physic'],
          attacking_crossing: row['attacking_crossing'],
          attacking_heading_accuracy: row['attacking_heading_accuracy'],
          attacking_short_passing: row['attacking_short_passing'],
          skill_dribbling: row['skill_dribbling'],
          skill_fk_accuracy: row['skill_fk_accuracy'],
          skill_long_passing: row['skill_long_passing'],
          skill_ball_control: row['skill_ball_control'],
          movement_acceleration: row['movement_acceleration'],
          movement_spring_speed: row['movement_spring_speed'],
          power_shot_power: row['power_shot_power'],
          power_jumping: row['power_jumping'],
          power_stamina: row['power_stamina'],
          power_strength: row['power_strength'],
          power_long_shots: row['power_long_shots'],
          defending_marking_awareness: row['defending_marking_awareness'],
          defending_standing_tackle: row['defending_standing_tackle'],
          defending_sliding_tackle: row['defending_sliding_tackle'],
          player_face_url: row['player_face_url'],
          heigh_cm: row['heigh_cm'],
          weight_kg: row['weight_kg']
        ).first_or_create
      end
    end
  end
end
