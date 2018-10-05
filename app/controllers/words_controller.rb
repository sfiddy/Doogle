require_relative '../../lib/web_services/dictionary_api'

class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :all_words, only: [:new, :create]
  attr_accessor :term

  def index
    @words = Word.all
  end

  def show
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = Word.new(word_params)
    
    respond_to do |format|
      if word_is_valid
        @word.set_valid(true)
        @pronunciation = get_pronunciation(@word.term)
        
        format.js
        format.json { render :show, status: :created, location: @word }
        
        if word_not_in_database
          @definitions = make_api_call_and_parse_payload(@word.term)
          save_word_and_definitions_to_database(@word, @definitions)
        else
          # @pronunciation = retrieve_pronunciation_from_database(@word.term) # implement once pronunciation is added to words table
          @definitions = retrieve_definitions_from_database(@word.term)
        end
      else
        begin
          raise "#{@word.term} is not a real word"
        rescue StandardError => e
          @word.set_valid(false)
          @word.generate_errors
          format.js
          format.html { render :new }
          format.json { render json: e, status: :unprocessable_entity }  
        end
      end
      
    end
  end

  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def word_params
      params.require(:word).permit(:term)
    end
    
    def set_word
      @word = Word.find(params[:id])
    end
    
    def all_words
      @words = Word.all
    end
    
    def word_is_valid
      word = Word.new(word_params)
      
      return true unless word.term.empty? || word_does_not_exist
    end
    
    def word_does_not_exist
      word = Word.new(word_params)
      definitions = make_api_call_and_parse_payload(word.term)
      # definitions = get_definitions(word.term)
      
      return true if definitions.empty?
    end
    
    def word_not_in_database
      word = Word.new(word_params)
      searched_word ||= Word.find_by(term: word.term)
      
      return true if searched_word.nil?
    end
    
    def make_api_call_and_parse_payload(term)
      service = WebServices::DictionaryApi.new(term)
      definitions = service.all_definitions
      
      if definitions
        definitions
      else
        Array.new
      end
    end
    
    def save_word_and_definitions_to_database(word, definitions)
      if word.save
        definitions.each do |d|
          word.definitions.create({ definition: d })
        end
      end
    end 
    
    def retrieve_definitions_from_database(term)
      word = Word.find_by(term: term)
      definitions_from_table = word.definitions
      
      definitions = Array.new
      
      definitions_from_table.each do |d|
        definitions.push(d.definition)
      end
      
      definitions
    end
  
    def get_pronunciation(term)
      service = WebServices::DictionaryApi.new(term)
      @pronunciation = service.get_pronunciation
    end
end
