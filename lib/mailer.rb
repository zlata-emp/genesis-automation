# Checks for lost password mails.
#
# ##### Usage:
#   **<code>Mailer.recieved_lost_pass_mail</code>**
# will return boolean if mail was recieved in the configured mail in Environment::MAIL
class Mailer
  def initialize
    @gmail       = Gmail.connect(Environment::MAIL[:address], 'Test1234!!')
    @subject     = Environment::MAIL[:subject]
    @from        = Environment::MAIL[:from]
    @max_retries = Environment::MAIL[:retries]
    @retry_sleep = Environment::MAIL[:retry_sleep]
  end

  def self.recieved_lost_pass_mail
    Mailer.new.check_unread_lost_pass
  end

  def check_unread_lost_pass
    read_all_lost_pass_mails
    return false unless retry_recieve_lost_pass_mail

    read_all_lost_pass_mails
  end

  private

  attr_reader :gmail

  def read_all_lost_pass_mails
    gmail.inbox.find(
      :unread,
      subject: @subject,
      after:   Date.parse(Time.now.utc.strftime('%Y%m%d_%H')),
      from:    @from
    ).each do |email|
      # p email.message.from
      p email.subject
      # p email.message.body.raw_source
      # p email.message.body.raw_source.include?('Reset password')
      email.read!
    end
  end

  def retry_recieve_lost_pass_mail
    @max_retries.times do
      unread_count = check_unread_lost_pass_count
      return true if unread_count.positive?

      sleep(@retry_sleep)
    end

    false
  end

  def check_unread_lost_pass_count
    gmail.inbox.count(
      :unread,
      subject: @subject,
      after:   Date.parse(Time.now.utc.strftime('%Y%m%d_%H')),
      from:    @from
    )
  end
end
