class CleanupNetworks < ActiveRecord::Migration
  def change
    remove_column :attachments, :network_id
    remove_column :conversations, :network_id
    remove_column :invitations, :network_id
    remove_column :memberships, :network_id
    remove_column :messages, :network_id
    remove_column :summaries, :network_id
    drop_table :networks
  end
end
