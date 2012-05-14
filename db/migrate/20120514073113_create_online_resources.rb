class CreateOnlineResources < ActiveRecord::Migration
  def change
    create_table :online_resources do |t|
      t.string :name
      t.string :url
      t.string :description
      t.integer :user_id #contributor
      t.references :resourceable, :polymorphic => true
      
      t.timestamps
    end
  end
end
