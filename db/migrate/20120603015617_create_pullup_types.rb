class CreatePullupTypes < ActiveRecord::Migration
  def change
    create_table :pullup_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
