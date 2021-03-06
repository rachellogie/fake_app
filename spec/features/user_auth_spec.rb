require 'rails_helper'

feature 'user auth' do

  let(:user) {create(:user)}

  scenario 'user can register' do
    visit root_path
    click_link 'Register'
    fill_in 'Email', with: 'shaniqua@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Register'
    expect(page).to have_content 'Successfully Registered!'
  end

  scenario 'user sees errors if registration unsuccessful' do
    visit root_path
    click_link 'Register'
    fill_in 'Email', with: 'shaniqua@example.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Register'
    expect(page).to have_content 'Password is too short'
  end

  scenario 'user can login' do
    visit root_path
    login_person(user.email, 'password')
    expect(page).to have_content 'Successfully logged in!'
  end

  scenario 'user sees error message if they enter an incorrect email/password combo' do
    visit root_path
    login_person(user.email, 'incorrect')
    expect(page).to have_content 'Incorrect email/password combo'
  end

  scenario 'user can logout' do
    login_person(user.email, 'password')
    click_link 'Logout'
    expect(page).to have_content 'Successfully logged out!'
  end

  scenario 'user sees login/register links if not logged in and logout link if logged in' do
    login_person(user.email, 'password')
    expect(page).to_not have_link 'Login'
    expect(page).to_not have_link 'Register'
    expect(page).to have_link 'Logout'

    click_link 'Logout'
    expect(page).to have_link 'Login'
    expect(page).to have_link 'Register'
    expect(page).to_not have_link 'Logout'
  end

end