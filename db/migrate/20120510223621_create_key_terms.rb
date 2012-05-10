class CreateKeyTerms < ActiveRecord::Migration
  def change
    create_table :key_terms do |t|
      t.integer :unit_id
      t.string :term

      t.timestamps
    end
  end
end
