require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "magic_seawead_API" do
    # get the surf data and check it's not nil
    assert_not_nil(UserMailer.get_surf_data(), "No data returned from MagicSeaweed API")
  end

  test "send_report" do
    # Create the email and store it for further assertions
    email = UserMailer.surf_report('testUser',
                                     'randy@example.com')
    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['notifications@randy.com'], email.from
    assert_equal ['randy@example.com'], email.to
    assert_equal 'Surf Report - Maroochydore', email.subject
  end


end
