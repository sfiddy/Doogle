require 'rails_helper'

RSpec.describe Word, type: :model do
  
  describe "word search validation" do
    
    context "an empty word" do
      it "should validate the presence of term" do
        should validate_presence_of(:term)
      end
      
      it "should display an error" do
        word = Word.new(term: ' ')
        word.valid?
        expect(word.errors[:term]).not_to be_empty
      end
    end
    
    context "an invalid word" do
      it "should display an error"
      it "should not be stored in the database"
    end
    
    context "an valid word" do
      it "should search the local database"
      it "should make an API call if not in the local database"
      it "isn't in the local database should be stored in the database"
    end
    
  end
  
end
