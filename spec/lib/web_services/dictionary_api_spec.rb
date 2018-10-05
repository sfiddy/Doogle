require "rails_helper"

RSpec.describe WebServices::DictionaryApi do
  
  describe ".base_url" do
    let (:base_url) {"https://www.dictionaryapi.com/api/v1/references/collegiate/xml/"}
    
    it "should not be nil" do
      expect(WebServices::DictionaryApi.base_url).to_not be_nil
    end
    
    it "should return the correct url for the dictionaryapi" do
      expect(WebServices::DictionaryApi.base_url).to eq(base_url)
    end
  end
  
  describe ".full_url" do
    let (:full_url) {"https://www.dictionaryapi.com/api/v1/references/collegiate/xml/apple?key=#{ENV['DICTIONARY_API_KEY_DEV']}"}
    subject { WebServices::DictionaryApi.new("apple") }
    
    
    it "should include the dictionary api key parameter" do
      expect(subject.full_url).to include(ENV['DICTIONARY_API_KEY_DEV'])
    end
    
    it "should include the term parameter" do
      expect(subject.full_url).to include("apple")
    end
    
    it "should properly concatanate the full url" do
      expect(subject.full_url).to eq(full_url)
    end
  end
  
  describe ".all_definitions" do
    context "for a valid word" do
      it "should not include any empty definitions" do
        subject = WebServices::DictionaryApi.new("test")
        parsed_definitions = subject.all_definitions
        
        parsed_definitions.each do |d|
          expect(d).to_not be_empty
        end
      end
      
      it "should only include definitions for the searched word" do
        subject = WebServices::DictionaryApi.new("apple")
        payload = Nokogiri::XML(subject.fetch_definitions.body)
        
        similar_word_entry = payload.xpath("//entry")[1]
        similar_word_definition = similar_word_entry.last_element_child.last_element_child.text.gsub!(/^:/, '')
        
        only_term_definitions = subject.all_definitions
        
        expect(only_term_definitions).to_not include(similar_word_definition)
      end
    end
    
    context "for an invalid word" do
      it "should have an empty definitions array" do 
        subject = WebServices::DictionaryApi.new("asdfg")
        definitions = subject.all_definitions
        expect(definitions.count).to eq(0)
      end
    end
  end
  
end

