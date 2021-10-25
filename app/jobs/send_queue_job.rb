class SendQueueJob < ApplicationJob
  queue_as :default

  def perform(arg1)
    # Do something later
    customer = Customer.notsent

    if customer.present?
      if customer.count < arg1
        nb = customer.count
      else
        nb = arg1
      end
      nb.times {
        customer_random = customer.order('RANDOM()').first
        CustomerMailer.with(customer: customer_random).new_customer_email.deliver_now
        customer_random.update(mail_sent: true, mail_date: DateTime.now)
      }
    end
  end
end
