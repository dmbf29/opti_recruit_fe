class AddLevelToLeague < ActiveRecord::Migration[6.1]
  def change
    add_column :leagues, :level, :integer
  end
end
