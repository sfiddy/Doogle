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
    
    @definitions = get_definitions(@word.term)
    @pronunciation = get_pronunciation(@word.term)
    
    
    respond_to do |format|
      if @definitions.empty?
        @word.set_valid(false)
      else
        @word.set_valid(true)
      end
      
      if @word.save
        puts "when word is saved, @word.get_valid : #{@word.get_valid}"
        format.js
        format.json { render :show, status: :created, location: @word }
      else
        puts "when word is not saved, @word.get_valid : #{@word.get_valid}"
        format.js
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
    
    def get_definitions(term)
      service = ::WebServices::DictionaryApi.new(term)
      @definitions = service.all_definitions
      
      if @definitions
        @definitions
      else
        Array.new
      end
    end
    
    def get_pronunciation(term)
      service = ::WebServices::DictionaryApi.new(term)
      @pronunciation = service.get_pronunciation
    end
    
end
