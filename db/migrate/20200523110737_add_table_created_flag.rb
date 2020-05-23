class AddTableCreatedFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :table_created, :boolean
  end
end
