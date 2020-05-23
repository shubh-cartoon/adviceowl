# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

users = []
1000.times { users << Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }

products = [] 
20000.times { products << Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }

10000000.times do
  user = users[rand(0...1000)]
  product = products[rand(0...20000)]
  aval_products = ActiveRecord::Base.connection.execute("select * from company_e108e7bada0a146a38bc54709219fef4_data where website_user_id = '#{user}' and product_id = '#{product}'")
  if aval_products.count > 0
    next
  else
    add_products = ActiveRecord::Base.connection.execute("INSERT INTO company_e108e7bada0a146a38bc54709219fef4_data values ('#{user}', '#{product}')")
  end
end