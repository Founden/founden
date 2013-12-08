class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :title
      t.string :slug
      t.hstore :data
      t.references :user, index: true
      t.references :network, index: true

      t.timestamps
    end

    add_index :conversations, :slug, :unique => true
  end
end
