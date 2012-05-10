class CreateAuthorOrgs < ActiveRecord::Migration
  def change
    create_table :author_orgs do |t|
      t.string :name

      t.timestamps
    end
  end
end
