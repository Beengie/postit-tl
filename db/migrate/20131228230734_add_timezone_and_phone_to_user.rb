class AddTimezoneAndPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string
    add_column :users, :phone, :integer
  end
end
