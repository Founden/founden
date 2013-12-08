class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :slug
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end

    add_index :users, :slug, :unique => true
  end
end
