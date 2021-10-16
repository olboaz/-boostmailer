class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show

  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user

    if @customer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :new
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  def import
    @user = current_user

    @company = @user.company
    product_import = ProductImport.new(company: @company)


    result = product_import.import(params[:file], @user)

    flash[:alert] = []

    if result.class == Array && result[0].any?
      if result[2] == "wrong file"
        flash[:alert] = result[0][0]
      elsif result[1] == result[0].count
        flash[:alert] = ["Toutes les lignes comportent des erreurs :"]
        result[0].each do |message|
          flash[:alert] << message
        end
      else
        flash[:alert] = ["Certaines lignes importées contiennent des erreurs :"]
        result[0].each do |message|
          flash[:alert] << message
        end
      end
      redirect_to root_path
    else
      redirect_to root_path, notice: "Données importées !"
    end
  end

  def send_mail
    # sélectionner 10 clients aléatoirement qui n'ont pas déjà été envoyé

    @customer = Customer.all

    @customer.each do |customer|
      CustomerMailer.with(customer: customer).new_customer_email.deliver_later
      customer.update(mail_sent: true, mail_date: DateTime.now)
    end

    redirect_to root_path
    flash[:success] = "Mails envoyés !"
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:restaurant_name, :email, :last_name, :first_name)
  end

end
