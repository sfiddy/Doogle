require 'rails_helper'

RSpec.describe Definition, type: :model do
  describe "Associations" do
    it "should belong to Word" do
      should belong_to :word
    end
    
    it "should validate presence of word id" do
      should validate_presence_of :word_id
    end
  end
end
