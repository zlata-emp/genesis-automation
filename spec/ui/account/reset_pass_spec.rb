# frozen_string_literal: true

describe 'Reset password', :ui do
  context 'when filling lost password form' do
    it 'sends mail', :mail do
      page = Browser.open_new_page
      page.navigate.to Environment::UI[:login_url]

      page.find_element(:link, 'Unable to log in?').click

      expect(page.title).to be == 'Passwords'

      Browser.fill_form_fields(
        page,
        finder:    :id,
        form_data: { admin_user_login: 'admin',
                     admin_user_email: 'genesis.test.automation@gmail.com' }
      ).find_element(:name, 'commit').click

      expect(Mailer.recieved_lost_pass_mail).to be true
    end
  end
end
