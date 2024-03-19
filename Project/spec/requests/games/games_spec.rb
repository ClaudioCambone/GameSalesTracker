require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before(:each) do
    # Create an example user and collection for every test
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: 'user') 
    @collection = Collection.create(name: 'Test Collection', user_id: @user.id)

    user = @user
    user.confirm # Confirm user email
    sign_in user # Sign in the user
  end

  describe 'POST #add_to_collection' do
    # For testing purposes we use a valid game_id (in this case, The Elder Scrolls V: Skyrim)
    let(:game_id) { '018d937f-2b23-73a3-9b40-d93860065d00' }

    context 'when valid game and collection IDs are provided' do
      context 'when game is not in the collection' do
        before do
          # Call the controller action with the known game_id
          post :add_to_collection, params: { game_id: game_id, collection_id: @collection.id }
        end

        it 'redirects back to root path' do
          expect(response).to redirect_to(root_path)
        end

        it 'sets a flash notice message indicating game added to collection successfully' do
          expect(flash[:notice]).to eq('Game added to collection successfully.')
        end
        
      end

      context 'when game is already in the collection' do
        before do
          # Ensure that the game is already in the collection
          GameCollection.create(game_id: game_id, collection_id: @collection.id)

          # Call the controller action with the known game_id
          post :add_to_collection, params: { game_id: game_id, collection_id: @collection.id }
        end

        it 'redirects back to root path' do
          expect(response).to redirect_to(root_path)
        end

        it 'sets a flash error message indicating game is already in the collection' do
          expect(flash[:error]).to eq('Game is already in the collection.')
        end

      end
    end

    context 'when invalid collection ID is provided' do
      before do
        # Call the controller action with valid game ID but invalid collection ID
        post :add_to_collection, params: { game_id: game_id, collection_id: nil }
      end

      it 'redirects back to root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash error message indicating invalid collection' do
        expect(flash[:error]).to eq('Invalid collection.')
      end
    end
  end
end
