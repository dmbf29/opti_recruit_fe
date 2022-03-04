class AddAlternateNameToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :alternate_name, :string
  end
end
