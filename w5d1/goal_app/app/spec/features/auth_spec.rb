# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'user', with: 'Max'
      fill_in 'passcode', with: 'taylor'
      click_on 'Create User'
    end

    scenario 'redirects to goals index page after signup' do
      expect(page).to have_content 'Goals Index Page'
    end
  end
end

feature 'logging in' do
  before(:each) do
    u = User.create!(username: 'Max', password: 'taylor')
    visit new_session_url
    fill_in 'user', with: 'Max'
    fill_in 'passcode', with: 'taylor'
    click_on 'Log In'
  end

  scenario 'shows username on the homepage after login' do
    expect(page).to have_content 'Max'
  end

end

feature 'logging out' do
  before(:each) do
    u = User.create!(username: 'Max', password: 'taylor')
    visit new_session_url
    fill_in 'user', with: 'Max'
    fill_in 'passcode', with: 'taylor'
    click_on 'Log In'
  end


  scenario 'begins with a logged out state' do
    expect(session[:session_token]).to be_nil
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_button('Sign Out')
    expect(page).to_not have_content('Max')
  end

end
