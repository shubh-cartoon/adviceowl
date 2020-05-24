require './lib/table_maker.rb'
require './lib/recommendation.rb'
class HomeController < ApplicationController
  require 'csv'
  include Recommendation
  before_action :skip_trackable
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def skip_trackable
    request.env['warden'].request.env['devise.skip_trackable'] = '1'
  end
  def index
    if user_signed_in?
      if current_user.email == 'flipkart@gmail.com'
        tbl = 'company_' + current_user.api_key + '_data'
        @users = ActiveRecord::Base.connection.execute("select DISTINCT website_user_id from #{tbl}") 
      end
    end      
  end
  def create_table_for_user
    if current_user.id?
      table_creation = TableMaker.new.make_a_table('company_' + current_user.api_key + '_data', current_user.api_key)
      if table_creation
        User.find(current_user.id).update(table_created: true)
      else
        User.find(current_user.id).update(table_created: false)
      end  
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def create
    tbl = 'company_' + params[:api_key] + '_data'
    results = ActiveRecord::Base.connection.execute("INSERT INTO #{tbl} values ('#{params[:website_user_id]}', '#{params[:product_id]}')")
    if results
      render json: {}, status: 200
    else
      render json: {error: 'unable to create'}, status: :not_found
    end
  end
  
  def recommended_products
    render json: {data: recommend_products}
  end
  
  def import
    tbl = 'company_' + current_user.api_key + '_data'
    file = params[:file]
    CSV.foreach((file.path), headers: true) do |user_product|
      ActiveRecord::Base.connection.execute("INSERT INTO #{tbl} values ('#{user_product[0]}', '#{user_product[1]}')")
    end
    flash[:notice] = "All user purchase data added to db."
    redirect_to root_path
  end
    
end
