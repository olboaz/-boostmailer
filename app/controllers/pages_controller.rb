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

    if params[:query]
      sql_query = "restaurant_name ILIKE :query OR last_name ILIKE :query OR first_name ILIKE :query OR email ILIKE :query OR address ILIKE :query"
      @customers = @customers.where(sql_query, query: "%#{params[:query]}%").order('restaurant_name ASC')
    end

    respond_to  do |format|
      format.html

      format.json { render json: { customers: @customers } }
    end
  end
  private

  def set_user
    @connected_user = current_user
  end

end
