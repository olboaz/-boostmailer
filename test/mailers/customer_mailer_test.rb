require 'test_helper'

class CustomerMailerTest < ActionMailer::TestCase
   test "the truth" do
      mail = CustomerMailer.new_customer_email
      assert_equal "New Email", mail.subject
      assert_equal ["to@example.org"], mail.to
      assert_equal ["from@example.com"], mail.from
      assert_match "Hi", mail.body.encoded

      assert true
   end
end
