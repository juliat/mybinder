class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :rationale
      t.text :prior_knowledge
      t.integer :topic_id
      t.integer :number

      t.timestamps
    end
  end
end
