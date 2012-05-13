class CreateTextReferences < ActiveRecord::Migration
  def change
    create_table :text_references do |t|
      t.string :book
      t.string :location
      t.references :textbookable, :polymorphic => true
      t.timestamps
    end
  end
end
