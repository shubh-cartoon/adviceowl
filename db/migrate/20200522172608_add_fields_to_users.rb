class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company_name, :string
    add_column :users, :api_key, :string
  end
end
