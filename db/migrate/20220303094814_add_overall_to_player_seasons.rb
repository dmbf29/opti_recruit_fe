class AddOverallToPlayerSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :player_seasons, :overall, :integer
    add_column :player_seasons, :potential, :integer
  end
end
