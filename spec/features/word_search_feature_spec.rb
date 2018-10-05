require 'rails_helper'

RSpec.feature "Word Search", js: true do
  scenario "A user searches for a valid word" do
    visit "/"
    fill_in "search-box", with: "Ruby"
    click_button "search-btn"
    
    expect(page).to have_css("#word", text: "Ruby")
    expect(page).to have_content("#pronunciation", text: "\ˈrü-bē")
    expect(page).to have_content("#definitions", text: "a precious stone that is a red corundum")
  end

  scenario "A user searches for an blank word" do
    visit "/"
    fill_in "search-box", with: ""
    click_button "search-btn"
    
    expect(page).to have_css("#errors", text: "Term can't be blank")
  end
  
  scenario "A user searches for a non-existent word" do
    visit "/"
    fill_in "search-box", with: "asdf"
    click_button "search-btn"
    
    expect(page).to have_css("#errors", text: "Term is not a real word")
  end
end