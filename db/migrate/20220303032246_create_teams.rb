class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :club_logo_url
      t.string :club_flag_url

      t.timestamps
    end
  end
end
