require 'rails_helper'

RSpec.describe WordsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Word. As you add validations to Word, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WordsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Word.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      word = Word.create! valid_attributes
      get :show, params: {id: word.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
    
    it "assigns new word search to @word" do
      get :new
      expect(assigns(:word)).to be_a_new(Word)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      word = Word.create! valid_attributes
      get :edit, params: {id: word.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with a valid word" do
      
      it "creates a new Word" do
        expect {
          post :create, params: {word: FactoryBot.attributes_for(:new_word)}, session: valid_session
        }.to change(Word, :count).by(1)
      end
      
      it "redirects to the created word's show page" do
        post :create, params: { word: FactoryBot.attributes_for(:new_word) }
        expect(response).to redirect_to(word_path(assigns[:word]))
      end
    end

    context "with an invalid word" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {word: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested word" do
        word = Word.create! valid_attributes
        put :update, params: {id: word.to_param, word: new_attributes}, session: valid_session
        word.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the word" do
        word = Word.create! valid_attributes
        put :update, params: {id: word.to_param, word: valid_attributes}, session: valid_session
        expect(response).to redirect_to(word)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        word = Word.create! valid_attributes
        put :update, params: {id: word.to_param, word: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested word" do
      word = Word.create! valid_attributes
      expect {
        delete :destroy, params: {id: word.to_param}, session: valid_session
      }.to change(Word, :count).by(-1)
    end

    it "redirects to the words list" do
      word = Word.create! valid_attributes
      delete :destroy, params: {id: word.to_param}, session: valid_session
      expect(response).to redirect_to(words_url)
    end
  end

end
