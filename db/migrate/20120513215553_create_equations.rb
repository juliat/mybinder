class CreateEquations < ActiveRecord::Migration
  def change
    create_table :equations do |t|
      t.string :latex
      t.string :image_file
      t.string :remote_image_url
      t.integer :mod_id
      t.integer :number

      t.timestamps
    end
  end
end
