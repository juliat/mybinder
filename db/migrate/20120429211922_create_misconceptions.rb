class CreateMisconceptions < ActiveRecord::Migration
  def change
    create_table :misconceptions do |t|
      t.string :statement
      t.integer :topic_id
      t.integer :unit_id
      t.timestamps
    end
  end
end
