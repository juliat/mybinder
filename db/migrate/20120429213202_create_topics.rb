class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :mod_id
      t.integer :number
      t.string  :name

      t.timestamps
    end
  end
end
