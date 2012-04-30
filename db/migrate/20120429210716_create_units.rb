class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :course_id
      t.string :name
      t.date :start_date
      t.integer :days
      t.text :notes

      t.timestamps
    end
  end
end
