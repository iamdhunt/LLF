require 'test_helper'

class ConvoMailerTest < ActionMailer::TestCase
  test "email_notification" do
    mail = ConvoMailer.email_notification
    assert_equal "Email notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
