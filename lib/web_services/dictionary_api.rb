module WebServices
  class DictionaryApi
      
    def initialize(term)
      @term = term
    end
    
    def self.base_url 
      "https://www.dictionaryapi.com/api/v1/references/collegiate/xml/"
    end
    
    def full_url
      "#{DictionaryApi.base_url}#{@term}?key=#{ENV['DICTIONARY_API_KEY_DEV']}"
    end
    
    
    def fetch_definitions 
      @response = Faraday.get full_url
    end
    
    def all_definitions
      @response = fetch_definitions
      @payload  = Nokogiri::XML(@response.body)
      @definitions = parse_definitions_payload(@payload)
    end
    
    
    def get_pronunciation
      @response = fetch_definitions
      @payload  = Nokogiri::XML(@response.body)
      @pronunciation = parse_payload_for_pronunciation(@payload)
      @pronunciation
    end
    
    private
      def parse_definitions_payload(payload)
        first_entry = payload.xpath("//entry").first

        @definitions = Array.new
        
        if first_entry
          first_entry.children.xpath("dt").each do |d|
            definition = d.text.gsub(/^:/, '')
            @definitions.push(definition) if definition != nil
          end          
        end
        
        return @definitions
      end
      
      def parse_payload_for_pronunciation(payload)
        first_entry = payload.xpath("//entry").first
        @pronunciation = ""
        
        if first_entry
          @pronunciation = first_entry.xpath("pr").text
        end
        
        @pronunciation
      end
  end
end