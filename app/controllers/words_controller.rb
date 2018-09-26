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
    @response = Faraday.get "https://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{@word.term}?key=cab72891-f003-43ef-a983-253666d45082"
    @xml_doc  = Nokogiri::XML(@response.body)
    @definitions = @xml_doc.xpath("//dt")
    
    parse_definitions_payload(@xml_doc)
    
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
        format.js
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
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
    def set_word
      @word = Word.find(params[:id])
    end
    
    def all_words
      @words = Word.all
    end

    def word_params
      params.require(:word).permit(:term)
    end
    
    def parse_definitions_payload(payload)
      # @filtered_definitions = payload.xpath("//entry[id=#{@word.term}]//dt")
      @filtered_definitions = payload.xpath("//def").first.xpath("//dt")
      
      puts "------------------------"
      puts @filtered_definitions
    end
end
