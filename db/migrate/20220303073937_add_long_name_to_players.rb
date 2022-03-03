class AddLongNameToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :long_name, :string
  end
end
