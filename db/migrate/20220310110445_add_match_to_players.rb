class AddMatchToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :match, :float
  end
end
