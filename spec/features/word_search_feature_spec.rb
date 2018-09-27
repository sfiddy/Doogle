require 'rails_helper'

RSpec.feature "Word Search" do
  scenario "A user searches for a valid word" do
    visit "/"
    fill_in "search-box", with: "Ruby"
    click_button "search-btn"
    expect(page).to have_content("Ruby")
  end

  scenario "A user searches for an blank word" do
    visit "/"
    fill_in "search-box", with: ""
    click_button "search-btn"
    expect(page).to have_content("can't be blank")
  end
  
  scenario "A user searches for a non-existent word"

end