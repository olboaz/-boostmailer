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
    customer_import = CustomerImport.new(user: @user)

    result = customer_import.import(params[:file])



    if result.class == Array && result[0].any?
          flash[:alert] = []
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
    countcustomer = Customer.notsent.count
    everyn = 2
    nbtime = (0..(countcustomer / everyn.to_f-1).ceil).to_a

    nbtime.each do |x|
      SendQueueJob.set(wait: x.minutes).perform_later(everyn)
    end

    # nb.times {
    #   @customer_random = @customer.order('RANDOM()').first
    #   CustomerMailer.with(customer: @customer_random).new_customer_email.deliver_later(wait: 15.minutes)
    #   @customer_random.update(mail_sent: true, mail_date: DateTime.now)
    # }
    customer = Customer.notsent
    if customer.present?
      redirect_to root_path
      flash[:notice] = "#{countcustomer} Mails programmés !"
    else
      redirect_to root_path
      flash[:notice] = "Il n'y a plus de mails à envoyer !"
    end

  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:restaurant_name, :email, :last_name, :first_name, :address)
  end

end
