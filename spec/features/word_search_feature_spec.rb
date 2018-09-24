require 'rails_helper'

RSpec.feature "Word Search" do
  scenario "A user searches for a valid word" do
    visit "/"
    fill_in "search-box", with: "Ruby"
    click_button "search-btn"

    # Some text to appear (presumably the definitions)
    expect(page).to have_content("Definitions: ")

    # TODO Find out how to pass regex to have_content(string)
  end

  scenario "A user searches for an blank word" do
    visit "/"
    fill_in "search-box", with: ""
    click_button "search-btn"
    expect(page).to have_content("can't be blank")
  end
  
  scenario "A user searches for a non-existent word"

end