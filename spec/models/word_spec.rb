require 'rails_helper'

RSpec.describe Word, type: :model do
  
  describe "word search validation" do
    
    context "with a valid word" do
      it "should set the word as valid"
    end
    
    context "with an invalid word" do
      it "should set the word as invalid"
      
      describe "that is blank" do
        it "should validate the presence of term" do
          should validate_presence_of(:term)
        end
        
        it "properly generates an error message"
        
        it "should add a message to errors array" do
          word = FactoryBot.build(:word, term: ' ' )
          word.valid?
          expect(word.errors[:term]).not_to be_empty
        end
      end
      
      describe "that does not exist" do
        it "should not save to the database"
        it "should add a message to errors array"
      end

    end
    
  end
  
  describe "table associations" do 
    it "words table should have a one-to-many association with definitions table"
  end
  
end
