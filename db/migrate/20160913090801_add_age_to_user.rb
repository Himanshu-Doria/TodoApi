class AddAgeToUser < ActiveRecord::Migration
  def change
    add_column :users, :remember_digest, :string
    add_column :users, :expires_on, :date
    add_column :users, :age, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :name, :string
  end
end
