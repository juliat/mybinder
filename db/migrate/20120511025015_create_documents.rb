class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :file
      t.integer :user_id
      t.references :documentable, :polymorphic => true

      t.timestamps
    end
  end
end
