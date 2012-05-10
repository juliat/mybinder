class CreateKeyConcepts < ActiveRecord::Migration
  def change
    create_table :key_concepts do |t|
      t.integer :unit_id
      t.integer :number
      t.string :statement

      t.timestamps
    end
  end
end
