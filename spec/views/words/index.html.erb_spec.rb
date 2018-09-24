require 'rails_helper'

RSpec.describe "words/index", type: :view do
  before(:each) do
    assign(:words, [
      Word.create!(
        :term => "Term"
      ),
      Word.create!(
        :term => "Term"
      )
    ])
  end

  it "renders a list of words" do
    render
    assert_select "tr>td", :text => "Term".to_s, :count => 2
  end
end
