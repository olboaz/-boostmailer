class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_user

  def home
    @customers =
      @connected_user
      .customers
      .order("restaurant_name ASC")

    if params[:name]
      sql_query = "restaurant_name ILIKE :name OR last_name ILIKE :name OR first_name ILIKE :name"
      @customers = @customers.where(sql_query, name: "%#{params[:name]}%").order('restaurant_name ASC')
    end
  end

  private

  def set_user
    @connected_user = current_user
  end

end
