class ChangeDobToDateInPlayers < ActiveRecord::Migration[6.1]
  def change
    change_column :players, :dob, 'date USING CAST(dob AS date)'
  end
end
