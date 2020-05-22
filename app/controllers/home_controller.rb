require './lib/table_maker.rb'
class HomeController < ApplicationController
  before_action :skip_trackable
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def skip_trackable
    request.env['warden'].request.env['devise.skip_trackable'] = '1'
  end
  def index
    # results = ActiveRecord::Base.connection.execute("I INTO ")
  end
  def create_table_for_user
    if current_user.id?
      table_creation = TableMaker.new.make_a_table('company_' + current_user.api_key + '_data')
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  def create
    tbl = 'company_' + params[:api_key] + '_data'
    tstamp = Time.now
    results = ActiveRecord::Base.connection.execute("INSERT INTO #{tbl} values (2, '#{params[:website_user_id]}', '#{params[:product_id]}', '#{tstamp}', '#{tstamp}')")
    if results
      render json: {}, status: 200
    else
      render json: {error: 'unable to create'}, status: :not_found
    end
  end
end
