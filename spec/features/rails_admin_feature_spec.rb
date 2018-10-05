require 'rails_helper'

RSpec.feature "Rails Admin" do
  scenario "A user wants to sign up for access to rails admin" do
    visit "/admins"
    click_button "sign-up-btn"
    
    fill_in "email-field", with: "john.doe@gmail.com"
    fill_in "password-field", with: "password"
    fill_in "password-confirmation-field", with: "password"
    
    click_button "sign-up-to-rails-admin-btn"
  end
  
  scenario "A user wants to log into rails admin" do
    visit "/admins"
    click_button "log-in-btn"
    
    fill_in "email-field", with: "john.doe@gmail.com"
    fill_in "password-field", with: "password"
    fill_in "password-confirmation-field", with: "password"
    
    click_button "log-in-to-rails-admin-btn"
  end
  
  scenario "A user wants to reset their password" do
    visit "/admins"
    click_link "forgot-password-link"
    
    fill_in "email-field", with: "john.doe@gmail.com"
    
    click_button "reset-password-btn"
    
    expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes")
  end
end