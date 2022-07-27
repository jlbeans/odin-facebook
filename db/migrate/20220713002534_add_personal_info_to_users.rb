class AddPersonalInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :location, :string
    add_column :users, :profession, :string
  end
end
