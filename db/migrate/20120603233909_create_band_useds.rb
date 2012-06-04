class CreateBandUseds < ActiveRecord::Migration
  def change
    create_table :band_useds do |t|
      t.integer :exercise_id
      t.integer :band_id

      t.timestamps
    end
  end
end
