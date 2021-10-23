class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    email_with_name = "Stephane Fersing <contact@limo-app.com>"

    attachments.inline["mailtext.png"] = File.read("#{Rails.root}/app/assets/images/mailtext.png")
    headers['Return-Receipt-To'] = email_with_name
    headers['Disposition-Notification-To'] = email_with_name
    headers['X-Confirm-Reading-To'] = email_with_name

    # pour gmail, le from & le reply_to doivent être identique pour pouvoir faire le reply_to
    mail( from: email_with_name,
          # reply_to: email_with_name,
          to: @customer.email,
          subject: "Limo, une question, une réponse pour votre restaurant"
    )

  end
end
