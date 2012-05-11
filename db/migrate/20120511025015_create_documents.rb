class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :description
      t.string :file
      t.references :documentable, :polymorphic => true

      t.timestamps
    end
  end
end
