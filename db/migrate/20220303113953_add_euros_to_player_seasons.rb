class AddEurosToPlayerSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :player_seasons, :value_eur, :integer
    add_column :player_seasons, :wage_eur, :integer
  end
end
