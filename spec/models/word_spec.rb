require 'rails_helper'

RSpec.describe Word, type: :model do
  
  describe "word search validation" do
    context "with a valid word" do
      it "should set the word as valid via .set_word" do
        word = Word.new(term: "apple")
        word.set_valid(true)
        expect(word.get_valid).to be_truthy
      end
      
      it "should not have any errors" do
        word = Word.new(term: "apple")
        expect(word.errors.full_messages).to be_empty
      end
    end
    
    context "with an invalid word" do
      it "should set the word as invalid via .set_word" do
        word = Word.new(term: "apple")
        word.set_valid(false)
        expect(word.get_valid).to be_falsey
      end
      
      describe "that is blank" do
        it "should validate the presence of term" do
          should validate_presence_of(:term)
        end
        
        it "should add an error message to the error array" do
          word = Word.new(term: "")
          word.generate_errors
          expect(word.errors.full_messages).to include("Term can't be blank")
        end
      end
      
      describe "that does not exist" do
        it "should add an error message to the error array" do
          word = Word.new(term: "asdf")
          word.set_valid(false) # manually set valid since this value is set in controller, not model
          word.generate_errors
          expect(word.errors.full_messages).to include("Term is not a real word")
        end
      end

    end
  end
  
  describe "Associations" do
    it "should have many definitions" do
      should have_many :definitions
    end
  end
end
