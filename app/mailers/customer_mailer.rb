class CustomerMailer < ApplicationMailer
  def new_customer_email
    @customer = params[:customer]

    email_with_name = "Stephane Fersing <contact@limo-app.com>"

    attachments.inline["logo-entete.png"] = File.read("#{Rails.root}/app/assets/images/logo-entete.png")
    attachments.inline["logo-piedpage.png"] = File.read("#{Rails.root}/app/assets/images/logo-piedpage.png")
    # headers['Return-Receipt-To'] = email_with_name
    # headers['Disposition-Notification-To'] = email_with_name
    # headers['X-Confirm-Reading-To'] = email_with_name

    # pour gmail, le from & le reply_to doivent être identique pour pouvoir faire le reply_to
    mail( from: email_with_name,
          reply_to: "stephane.fersing@limo-app.com",
          to: @customer.email,
          bcc: ["patrice.jaszczynski@limo-app.com","campagne_mail_001@limo-app.com","pierre.fersing@limo-app.com"],
          subject: "Limo, votre partenaire au quotidien pour améliorer votre rentabilité"
    )

  end
end
