class TableMaker < ActiveRecord::Migration[5.1]
  def make_a_table(table_name)
    create_table table_name do |t|
        t.string :website_user_id
        t.string :product_id
    end
  end
end