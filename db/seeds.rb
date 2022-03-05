require 'csv'
# puts "Destroying all players..."
# Player.destroy_all
# years = [18, 19, 20, 21, 22]
years = [22, 21]
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

def create_sofifa_teams(years)
  puts "Creating Teams and Leagues..."
  years.each do |year|
    filepath = "db/raw_data/players_#{year}.csv"
    next unless File.exist?(filepath)
    puts "opening #{filepath}..."

    CSV.foreach(filepath, headers: :first_row) do |row|
      next if SKIP_TEAMS.include?(row['league_name'])

      league = League.where(
        name: row['league_name'],
        level: row['league_level']
      ).first_or_create

      Team.where(
        name: row['club_name'],
        club_logo_url: row['club_name'],
        club_flag_url: row['club_logo_url'],
        league: league
      ).first_or_create
    end
  end
  puts "... created #{League.count} leagues"
  puts "... created #{Team.count} teams"
end

def update_teams_with_fbref(years)
  puts "Creating Teams..."
  years.each do |year|
    filepath = "db/raw_data/fbref_20#{year}.csv"
    next unless File.exist?(filepath)
    puts "opening #{filepath}..."

    user_team = nil
    CSV.foreach(filepath, headers: :first_row) do |row|
      next if SKIP_TEAMS.include?(row['league_name_sofifa'])

      league = League.find_by(name: row['league_name_sofifa'])
      until league
        puts "Couldn't find league: #{row['league_name_sofifa']}. Enter proper name:"
        print '> '
        user_league = gets.chomp
        league = League.find_by(name: user_league)
      end

      team = Team.find_by(name: row['team']) || Team.find_by(alternate_name: row['team']) || Team.find_by(name: 'FC ' + row['team']) || Team.find_by(name: 'SC ' + row['team']) || Team.find_by(name: row['team'] + ' FC') || Team.find_by(name: row['team'] + ' SC')
      until team || user_team == 'skip'
        puts "** #{row['team']} ** Not found."
        puts league.teams.order(:name).pluck(:name).join('  ')
        print '> '
        user_team = gets.chomp
        team = Team.find_by(name: user_team)
        team&.update(alternate_name: row['team'])
      end
    end
  end
  puts "... created #{Team.count}"
end

def fbref_players(years)
  puts "Creating Players..."
  years.each do |year|
    filepath = "db/raw_data/fbref_20#{year}.csv"
    next unless File.exist?(filepath)
    puts "opening #{filepath}..."
    season = Season.where(
      year: "20#{year}"
    ).first_or_create

    CSV.foreach(filepath, headers: :first_row) do |row|
      next if SKIP_TEAMS.include?(row['league_name_sofifa'])

      team = Team.find_by(name: row['team']) || Team.find_by(alternate_name: row['team'])
      next unless team

      league = team.league
      user_short_name = nil

      first_letter = row['player'][0]
      last_names = row['player'].split[1..-1].join(' ')
      if last_names.blank?
        player = team.players.find_by(short_name: row['player']) || league.players.find_by(name: row['player']) || league.players.find_by(short_name: row['player']) || team.players.find_by(name: row['player']) || Player.find_by("long_name ILIKE ?", "%#{row['player']}%")
      else
        player = team.players.find_by("short_name ~* ?", "^#{first_letter}\.* #{last_names}") || team.players.find_by(short_name: row['player']) || team.players.find_by(name: row['player']) || league.players.find_by("short_name ~* ?", "^#{first_letter}\.* #{last_names}") || league.players.find_by(short_name: row['player']) || league.players.find_by(name: row['player']) || league.players.find_by("long_name ILIKE ?", "%#{row['player'].split[0]}%#{row['player'].split[1]}") || Player.find_by("long_name ILIKE ?", "%#{row['player']}%")
      end
      player&.update(name: row['player'])
      next unless player

      # until player || user_short_name == 'skip'
      #   user_short_name = nil
      #   shorts = team.players.order(:short_name).pluck(:short_name).join('  ')
      #   longs = team.players.order(:long_name).pluck(:long_name).join('  ')
      #   puts shorts
      #   puts ' - or - '
      #   puts longs
      #   puts
      #   puts "** #{row['player']} ** Not found."
      #   print '> '
      #   user_short_name = gets.chomp
      #   player = team.players.find_by(short_name: user_short_name) || team.players.find_by(long_name: user_short_name) || Player.find_by(long_name: user_short_name)
      #   p player
      #   player&.update(name: row['player'])
      # end

      ps = PlayerSeason.where(player: player, season: season)
      ps.update(
        games: row['games'],
        minutes: row['minutes'],
        goals: row['goals'],
        assists: row['assists'],
        goals_pens: row['goals_pens'],
        goals_per90: row['goals_per90'],
        assists_per90: row['assists_per90'],
        goals_pens_per90: row['goals_pens_per90'],
        xg: row['xg'],
        npxg: row['npxg'],
        xa: row['xa'],
        xg_per90: row['xg_per90'],
        xa_per90: row['xa_per90'],
        npxg_per90: row['npxg_per90'],
        passes_completed: row['passes_completed'],
        passes: row['passes'],
        passes_completed_short: row['passes_completed_short'],
        passes_short: row['passes_short'],
        passes_completed_medium: row['passes_completed_medium'],
        passes_medium: row['passes_medium'],
        passes_completed_long: row['passes_completed_long'],
        passes_long: row['passes_long'],
        progressive_passes: row['progressive_passes'],
        gca: row['gca'],
        tackles: row['tackles'],
        dribble_tackles: row['dribble_tackles'],
        pressures: row['pressures'],
        blocks: row['blocks'],
        interceptions: row['interceptions'],
        clearances: row['clearances'],
        touches_att_pen_area: row['touches_att_pen_area'],
        dribbles_completed: row['dribbles_completed'],
        progressive_carries: row['progressive_carries'],
        progressive_passes_received: row['progressive_passes_received'],
        crosses: row['crosses'],
        tackles_won: row['tackles_won'],
        aerials_won: row['aerials_won']
      )
    end
  end
  puts "... created #{Player.count} players."
end

def sofifa_players(years)
  errors = []
  puts "Creating Players..."
  years.each do |year|
    filepath = "db/raw_data/players_#{year}.csv"
    next unless File.exist?(filepath)

    season = Season.where(
      year: "20#{year}"
    ).first_or_create
    puts "opening #{filepath}..."
    CSV.foreach(filepath, headers: :first_row) do |row|
      next if SKIP_TEAMS.include?(row['league_name'])

      player = Player.where(
        position: row['player_positions'].split(', ').first,
        sofifa_id: row['sofifa_id'],
        player_url: row['player_url'],
        dob: row['dob'],
        nationality_name: row['nationality_name'],
        preferred_foot: row['preferred_foot'],
        short_name: row['short_name'],
        long_name: row['long_name']
      ).first_or_create
      if player.errors.any?
        p player.errors.full_messages
        puts
      end
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
  # Add errors to csv??
  puts "... created #{Player.count} players."
end

# create_sofifa_teams(years)
# update_teams_with_fbref(years)
# sofifa_players(years)
fbref_players(years)
