namespace :player do
  desc "Creates a JSON with all sofifa_id"
  task sofifa_id: :environment do
    ids = Player.where.not(name: nil).pluck(:sofifa_id)

    File.open('db/sofifa_ids.json', "wb") do |file|
      file.write(JSON.generate(ids))
    end
  end
end
