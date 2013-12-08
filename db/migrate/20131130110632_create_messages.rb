class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :slug
      t.hstore :data
      t.references :user, index: true
      t.references :network, index: true
      t.references :conversation, index: true
      t.references :summary, index: true

      t.timestamps
    end

    add_index :messages, :slug, :unique => true
  end
end
