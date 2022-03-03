class CreatePlayerSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :player_seasons do |t|
      t.references :player, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true
      t.integer :international_reputation
      t.integer :release_cause_eur
      t.integer :pace
      t.integer :shooting
      t.integer :passing
      t.integer :dribbling
      t.integer :defending
      t.integer :physic
      t.integer :attacking_crossing
      t.integer :attacking_heading_accuracy
      t.integer :attacking_short_passing
      t.integer :skill_dribbling
      t.integer :skill_fk_accuracy
      t.integer :skill_long_passing
      t.integer :skill_ball_control
      t.integer :movement_acceleration
      t.integer :movement_spring_speed
      t.integer :power_shot_power
      t.integer :power_jumping
      t.integer :power_stamina
      t.integer :power_strength
      t.integer :power_long_shots
      t.integer :defending_marking_awareness
      t.integer :defending_standing_tackle
      t.integer :defending_sliding_tackle
      t.string :player_face_url
      t.integer :heigh_cm
      t.integer :weight_kg

      t.timestamps
    end
  end
end
