class AddParentMessageToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :parent_message, index: true
  end
end
