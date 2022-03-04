class AddTeamToPlayerSeasons < ActiveRecord::Migration[6.1]
  def change
    remove_reference :players, :team, null: false, foreign_key: true
    add_reference :player_seasons, :team, null: false, foreign_key: true
  end
end
