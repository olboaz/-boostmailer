# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview

  def new_customer_email_preview
    @customer = Customer.last
    CustomerMailer.with(customer: @customer).new_customer_email
  end

end
