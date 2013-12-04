class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :slug
      t.string :type
      t.hstore :data
      t.attachment :attachment
      t.references :user, index: true
      t.references :network, index: true
      t.references :conversation, index: true
      t.references :message, index: true
      t.references :summary, index: true

      t.timestamps
    end

    add_index :attachments, :slug
  end
end
