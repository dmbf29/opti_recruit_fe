class AddShortNameToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :short_name, :string
  end
end
