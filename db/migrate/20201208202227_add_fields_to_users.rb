class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :name, :string
    add_column :users, :url, :string
    add_column :users, :short_url, :string
    add_column :users, :tags, :text
    add_column :users, :friends, :text
  end

  def down
    remove_column :users, :name
    remove_column :users, :url
    remove_column :users, :short_url
    remove_column :users, :tags
    remove_column :users, :friends
  end
end
