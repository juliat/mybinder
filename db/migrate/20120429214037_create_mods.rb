class CreateMods < ActiveRecord::Migration
  def change
    create_table :mods do |t|
      t.integer :number
      t.integer :days
      t.integer :unit_id
      t.timestamps
    end
  end
end
