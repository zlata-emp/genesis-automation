describe 'Login', :ui do
  let(:page) { Browser.reuse_page }

  it 'shows login page' do
    page.navigate.to Environment::UI[:login_url]

    expect(page.title).to be == 'Sessions'
    expect(page.find_element(:id, 'admin_user_login')).not_to be_nil
  end

  it 'sign in' do
    page.navigate.to Environment::UI[:login_url]

    user_field = page.find_element(:id, 'admin_user_login')
    user_field.click
    user_field.send_keys 'admin'

    pass_field = page.find_element(:name, 'admin_user[password]')
    pass_field.click
    pass_field.send_keys 'Test1234!!'

    submit_button = page.find_element(:name, 'commit')
    submit_button.click

    expect(page.title).to be == 'admin - Dashboard: index'
  end
end
