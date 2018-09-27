require 'rails_helper'

RSpec.feature "Word Search", js: true do
  scenario "A user searches for a valid word" do
    visit "/"
    fill_in "search-box", with: "Ruby"
    click_button "search-btn"
    
    save_page
    within '#word' do
      expect(page).to have_content("Ruby")
    end
  end

  scenario "A user searches for an blank word" do
    visit "/"
    fill_in "search-box", with: ""
    click_button "search-btn"
    expect(page).to have_content("can't be blank")
  end
  
  scenario "A user searches for a non-existent word"

end