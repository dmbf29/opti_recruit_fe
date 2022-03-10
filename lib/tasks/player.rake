namespace :player do
  desc "Creates a JSON with all sofifa_id"
  task sofifa_id: :environment do
    ids = Player.where.not(name: nil).pluck(:sofifa_id)

    File.open('db/sofifa_ids.json', "wb") do |file|
      file.write(JSON.generate(ids))
    end
  end

  desc "Fills players with predicted values"
  task predict_value: :environment do
    season = Season.find_by(year: "2022")
    puts "Opening Csv..."
    CSV.foreach('db/raw_data/predicted_23.csv', headers: :first_row) do |row|
      player = Player.find_by(sofifa_id: row['sofifa_id'].to_i)
      if player
        ps = player.player_seasons.find_by(season: season)
        if ps
          if player.age > 33
            ps.update(value_eur_proj_next: row['predict_value'].to_f * 0.8)
          elsif [31, 32, 33].include?(player.age)
            ps.update(value_eur_proj_next: row['predict_value'].to_f * 0.9)
          else
            ps.update(value_eur_proj_next: row['predict_value'].to_f)
          end
        else
          puts player.short_name
        end
      else
        p row['sofifa_id'].to_i
      end
    end
  end
end
