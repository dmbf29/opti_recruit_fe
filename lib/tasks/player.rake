namespace :player do
  desc "Creates a JSON with all sofifa_id"
  task sofifa_id: :environment do
    ids = Player.where.not(name: nil).pluck(:sofifa_id)

    File.open('db/sofifa_ids.json', "wb") do |file|
      file.write(JSON.generate(ids))
    end
  end

  desc "Fills players with predicted values"
  task sofifa_id: :environment do
    CSV.foreach(filepath, headers: :first_row) do |row|
      player = Player.find_by(sofifa_id: row['sofifa_id'])
      ps = player.player_seasons.last
      ps.update(value_eur_proj_next: row['predict_value'])
    end
  end
end
