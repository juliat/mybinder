class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :course_id
      t.integer :number
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :days
      t.text :notes

      t.timestamps
    end
  end
end
