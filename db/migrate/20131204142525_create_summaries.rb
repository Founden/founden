class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :title
      t.string :slug
      t.hstore :data
      t.references :network, index: true
      t.references :conversation, index: true

      t.timestamps
    end

    add_index :summaries, :slug, :unique => true
  end
end
