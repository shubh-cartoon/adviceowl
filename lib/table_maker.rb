class TableMaker < ActiveRecord::Migration[5.1]
  def make_a_table(table_name,api_key)
    create_table table_name, :id => false do |t|
        t.string :website_user_id
        t.string :product_id
    end
    add_index table_name, :website_user_id, name: api_key
  end
end