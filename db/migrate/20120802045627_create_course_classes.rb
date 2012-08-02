class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.integer :teacher_id
      t.integer :course_id
      t.string :name
	  t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
