class ChangeNameFieldOfUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :last_name, :string
    rename_column :users, :first_name, :name
  end
end
