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
    
    it "should assign the searched word to @word" do
      post :create, params: { :word => { :term => "novelty" } }, format: :js
      
      expect(assigns.keys).to include('word')
      expect(assigns(:word).term).to eq("novelty")
    end
    
    
    context "with a valid word" do 
      
      it "should assign @definitions with an array of definitions" do
        post :create, params: { :word => { :term => "novelty" } }, format: :js
        
        expect(assigns.keys).to include('definitions')
        expect(assigns(:definitions)).to be_an Array
      end
      
      describe "that does not exist in the database" do 
        
        it "should store the word in the database" do
          expect {
            post :create, params: { :word => { :term => "novelty" } }, format: :js
          }.to change(Word, :count).by(1)
        end
        
        it "should store the definitions in the database" do
          expect {
            post :create, params: { :word => { :term => "novelty" } }, format: :js
          }.to change(Definition, :count)
        end
        
        it "should not redirect to a different page" do
          post :create, params: { :word => { :term => "novelty" } }, format: :js
          
          expect(response).to render_template("words/create")
        end  
        
      end
      
      describe "that does exist in the database" do 
        
        it "should retrieve the pronunciation from the database" do 
          expect(assigns.keys).to_not include('pronunciation')
          post :create, params: { :word => { :term => "novelty" } }, format: :js
          expect(assigns.keys).to include('pronunciation')
        end
        
        it "should retrieve the definitions from the database" do
          expect(assigns.keys).to_not include('definitions')
          post :create, params: { :word => { :term => "novelty" } }, format: :js
          expect(assigns.keys).to include('definitions')
        end
        
        it "should not store the word in the database" do 
          post :create, params: { :word => { :term => "novelty" } }, format: :js
          
          expect {
            post :create, params: { :word => { :term => "novelty" } }, format: :js
          }.to_not change(Word, :count) 
        end
        
        it "should not store the definitions in the database" do
          post :create, params: { :word => { :term => "novelty" } }, format: :js
          
          expect {
            post :create, params: { :word => { :term => "novelty" } }, format: :js
          }.to_not change(Definition, :count) 
        end
        
      end
      
    end
    
    context "with an invalid word" do 
    
      describe "that is blank" do
        
        it "should raise an error" do 
          expect { 
            post :create, params: { :word => { :term => " " } }, format: :js
          }.to raise_error
        end
        
        it "should not assign @definitions or @pronunciation" do
          expect { 
            post :create, params: { :word => { :term => " " } }, format: :js
          }.to raise_error
          
          expect(assigns.keys).to_not include('definitions')
          expect(assigns.keys).to_not include('pronunciation')
        end
        
        it "should not save the invalid word in the database" do # TODO - determine if it's worth figuring out how to write test
          expect { 
            post :create, params: { :word => { :term => " " } }, format: :js
          }.to raise_error.and change(Word, :count).by(0)
        end
        
      end
    
      describe "that does not exist" do 
        
        it "should raise an error" do # for some reason an error isn't detected
          pending
          expect { 
            post :create, params: { :word => { :term => "asdf" } }, format: :js
          }.to raise_error
        end
        
        it "should not assign @definitions or @pronunciation" do
          post :create, params: { :word => { :term => "asdf" } }, format: :js
          
          expect(assigns(:definitions)).to be_empty
          expect(assigns.keys).to_not include('pronunciation')
        end
        
        it "should not save the invalid word or definitions to the database" do
          expect { 
            post :create, params: { :word => { :term => "asdf" } }, format: :js
          }.to_not change(Word, :count)
          expect { 
            post :create, params: { :word => { :term => "asdf" } }, format: :js
          }.to_not change(Definition, :count)
          
          word_query = Word.find_by(term: "asdf")
          
          expect(word_query).to be_falsey
          expect{ word_query.definitions }.to raise_error # used raise_error b/c unable to query nil word obj. If error is raised then no definition exists in the database for that queried word.
        end

        it "should return a success response (i.e. to display the 'new' template)" do
          post :create, params: { :word => { :term => "asdf" } }, format: :js
          expect(response).to be_successful
        end
        
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
