class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    email_with_name = "#{@customer.first_name} <#{@customer.last_name}>"

    headers['Return-Receipt-To'] = email_with_name
    headers['Disposition-Notification-To'] = email_with_name
    headers['X-Confirm-Reading-To'] = email_with_name

    # pour gmail, le from & le reply_to doivent être identique pour pouvoir faire le reply_to
    mail( from: "contact@limo-app.com",
          # reply_to: email_with_name,
          to: @customer.email,
          subject: "Limo - Invitation"
    )

  end
end
