class AddRestaurantToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :restaurant_name, :string
    add_column :customers, :mail_sent, :boolean, default: false
    add_column :customers, :mail_date, :datetime
  end
end
