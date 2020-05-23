module Recommendation
  def recommend_products
    tbl = 'company_' + params[:api_key] + '_data'
    other_users = ActiveRecord::Base.connection.execute("select DISTINCT website_user_id from #{tbl} where website_user_id != '#{params[:website_user_id]}'")
    recommended = Hash.new(0)
    other_users.each do |user|
      user_products = ActiveRecord::Base.connection.execute("select product_id from #{tbl} where website_user_id = '#{user['website_user_id']}'")
      user_products_arr = []
      user_products.each do |product|
        user_products_arr << product['product_id']
      end  
      self_products = ActiveRecord::Base.connection.execute("select product_id from #{tbl} where website_user_id = '#{params[:website_user_id]}'")
      self_products_arr = []
      self_products.each do |product|
        self_products_arr << product['product_id']
      end
      common_products = user_products_arr & self_products_arr
      weight = common_products.size.to_f / user_products_arr.size
      
      (user_products_arr - common_products).each do |product|
        product_weight_hash = {'product_id': product, 'weight': weight} 
        recommended[product_weight_hash] += weight
      end
    end
    sorted_recommended = recommended.sort_by { |key, value| value }.reverse
    sorted_recommended[0...9]
  end
end
