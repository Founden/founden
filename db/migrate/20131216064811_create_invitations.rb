class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :slug
      t.string :email
      t.references :user, index: true
      t.references :network, :index => true
      t.references :membership, :polymorphic => true, :index => true
      t.hstore :data

      t.timestamps
    end

    add_index :invitations, :slug
    add_index :invitations, :email
  end
end
