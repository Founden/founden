class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :title
      t.string :slug
      t.hstore :data
      t.references :user, index: true

      t.timestamps
    end

    add_index :networks, :slug, :unique => true
  end
end
