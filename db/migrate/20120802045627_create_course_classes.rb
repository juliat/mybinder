class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.integer :teacher_id
      t.integer :course_id
      t.string :name

      t.timestamps
    end
  end
end
