# frozen_string_literal: true

describe 'Login', :ui do
  it 'shows login page' do
    page = Browser.reuse_page
    page.navigate.to Environment::UI[:login_url]

    expect(page.title).to be == 'Sessions'
    expect(page.find_element(:id, 'admin_user_login')).not_to be_nil
  end

  it 'sign in' do
    page = Browser.reuse_page
    page.navigate.to Environment::UI[:login_url]

    Browser.fill_form_fields(page, finder: :id, form_data: { admin_user_login: 'admin' })
    Browser.fill_form_fields(page, finder: :name, form_data: { 'admin_user[password]': 'Test1234!!' })
    page.find_element(:name, 'commit').click

    expect(page.title).to be == 'admin - Dashboard: index'
  end
end
