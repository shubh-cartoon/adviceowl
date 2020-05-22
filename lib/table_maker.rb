class TableMaker < ActiveRecord::Migration[5.1]
  def make_a_table(table_name)
    create_table table_name do |t|
        t.string :website_user_id, null: false
        t.text :product_id,  null: false
        add_index :website_user_id
        add_index :product_id, :website_user_id
    end
  end
end