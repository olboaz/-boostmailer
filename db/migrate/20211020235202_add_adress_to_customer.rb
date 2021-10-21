class AddAdressToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :address, :string
  end
end
