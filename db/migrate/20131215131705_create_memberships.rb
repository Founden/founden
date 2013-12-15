class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :creator, index: true
      t.references :user, index: true
      t.references :network, index: true
      t.references :conversation, index: true
      t.hstore :data
      t.string :type
      t.string :slug

      t.timestamps
    end

    add_index :memberships, :type
    add_index :memberships, :slug, :unique => true

    # Add an index to attachment `type`
    add_index :attachments, :type
  end
end
