names = ["Mohamed Salah", "Sadio Mané", "Roberto Firmino", "Trent Alexander-Arnold", "Diogo Jota", "Luis Díaz", "Andrew Robertson", "Virgil van Dijk", " Alisson", "Xherdan Shaqiri", "Alex Oxlade-Chamberlain", " Fabinho", " Thiago", "Harvey Elliott", "Takumi Minamino"]

names.each do |name|
  overall = rand(80..90)
  Player.create!(
    name: name,
    age: rand(24..31),
    position: ['FW', 'MF', 'DF', 'GK'].sample,
    overall: overall,
    potential: overall + rand(0..8),
    value: rand(0..50) + 1000000,
    wage: rand(1..9) + 10000,
    total: rand(1000..2000)
  )
end
