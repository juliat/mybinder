class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :course_id
      t.string :name
      t.date :start_date
      t.integer :weeks

      t.timestamps
    end
  end
end
