# frozen_string_literal: true

describe 'Reset password', :ui do
  let(:page) { Browser.open_new_page }

  context 'when filling lost password form' do
    it 'sends mail', :mail do
      page.navigate.to Environment::UI[:login_url]

      page.find_element(:link, 'Unable to log in?').click

      user_field = page.find_element(:id, 'admin_user_login')
      user_field.click
      user_field.send_keys 'admin'

      user_field = page.find_element(:id, 'admin_user_email')
      user_field.click
      user_field.send_keys 'genesis.test.automation@gmail.com'

      expect(page.title).to be == 'Passwords'

      submit_button = page.find_element(:name, 'commit')
      submit_button.click

      expect(Mailer.recieved_lost_pass_mail).to be true
    end
  end
end
