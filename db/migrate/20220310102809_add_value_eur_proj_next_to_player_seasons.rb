class AddValueEurProjNextToPlayerSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :player_seasons, :value_eur_proj_next, :integer
  end
end
