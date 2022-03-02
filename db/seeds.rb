puts "Destroying all players..."
Player.destroy_all

names = ["Mohamed Salah", "Sadio Mané", "Roberto Firmino", "Trent Alexander-Arnold", "Diogo Jota", "Luis Díaz", "Andrew Robertson", "Virgil van Dijk", " Alisson", "Xherdan Shaqiri", "Alex Oxlade-Chamberlain", " Fabinho", " Thiago", "Harvey Elliott", "Takumi Minamino"]

names.each do |name|
  overall = rand(80..90)
  Player.create!(
    name: name,
    age: rand(24..31),
    position: ['FW', 'MF', 'DF', 'GK'].sample,
    overall: overall,
    potential: overall + rand(0..8),
    value: (rand(1..50).to_s + '000000').to_i,
    wage: (rand(1..9).to_s + '0000').to_i,
    total: rand(1000..2000)
  )
end
puts "... created #{Player.count} players."
