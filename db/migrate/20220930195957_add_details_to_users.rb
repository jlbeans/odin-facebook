class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :education, :string
    add_column :users, :relationship, :string
    add_column :users, :birthday, :date
  end
end
