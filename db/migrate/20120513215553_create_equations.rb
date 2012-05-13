class CreateEquations < ActiveRecord::Migration
  def change
    create_table :equations do |t|
      t.string :latex
      t.string :image_file
      t.integer :mod_id

      t.timestamps
    end
  end
end
