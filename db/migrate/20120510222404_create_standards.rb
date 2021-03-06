class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.integer :unit_id # temporary until standards are mapped to goals
      t.string :author_org_id
      t.string :author_org_code
      t.string :statement

      t.timestamps
    end
  end
end
