class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_user

  def home
    if @connected_user
      @customers =
        @connected_user
        .customers
        .order("restaurant_name ASC")
    end

    if params[:search]
      sql_query = "restaurant_name ILIKE :search OR last_name ILIKE :search OR first_name ILIKE :search OR email ILIKE :search OR address ILIKE :search"
      @customers = @customers.where(sql_query, search: "%#{params[:search]}%").order('restaurant_name ASC')

    end


  end

  private

  def set_user
    @connected_user = current_user
  end

end
