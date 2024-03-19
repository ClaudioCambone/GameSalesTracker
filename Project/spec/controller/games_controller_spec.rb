require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    # Test 1: Verifica il corretto funzionamento del metodo #search
    describe "GET #search" do
      context "with valid search query" do
        before do
          # Stub dei metodi utilizzati nel controller per simulare i risultati della ricerca
          allow(controller).to receive(:search_games).and_return([
            { 'id' => '018d937f-0616-7253-abb7-da2dddfa66f1', 'title' => 'NARUTO: Ultimate Ninja STORM', 'slug' => 'naruto-ultimate-ninja-storm', 'type' => 'game', 'mature' => false },
            { 'id' => '018d937f-3ec2-72b5-b641-026a3a199f0b', 'title' => 'Naruto to Boruto Shinobi Striker', 'slug' => 'naruto-to-boruto-shinobi-striker', 'type' => 'game', 'mature' => false }
          ])
          get :search, params: { search_query: 'naruto' } # Simula la richiesta GET con una query di ricerca valida
        end
  
        # Verifica che la richiesta HTTP abbia successo
        it 'returns HTTP success' do
          expect(response).to have_http_status(:success)
        end
  
        # Verifica che il template di ricerca sia renderizzato correttamente
        it 'renders the search template' do
          expect(response).to render_template(:search)
        end
  
        # Verifica che la variabile @games sia assegnata con i risultati della ricerca
        it 'assigns @games with search results' do
          # Estrai solo gli attributi necessari per il confronto
          expected_games = assigns(:games).map { |game| game.slice('id', 'title', 'slug', 'type', 'mature') }
  
          # Confronta solo gli attributi rilevanti per il test
          expect(expected_games).to eq([
            { 'id' => '018d937f-0616-7253-abb7-da2dddfa66f1', 'title' => 'NARUTO: Ultimate Ninja STORM', 'slug' => 'naruto-ultimate-ninja-storm', 'type' => 'game', 'mature' => false },
            { 'id' => '018d937f-3ec2-72b5-b641-026a3a199f0b', 'title' => 'Naruto to Boruto Shinobi Striker', 'slug' => 'naruto-to-boruto-shinobi-striker', 'type' => 'game', 'mature' => false }
          ])
        end
      end
    end

    # Test 2: Verifica il corretto funzionamento del metodo #search quando la query di ricerca è vuota
    describe "GET #search" do
        context "with empty search query" do
            before do
               # Stub dei metodi utilizzati nel controller per simulare una ricerca vuota
               allow(controller).to receive(:search_games).and_return([])
                get :search, params: { search_query: '' } # Simula la richiesta GET con una query di ricerca vuota
            end

            # Verifica che la richiesta HTTP abbia successo
            it 'returns HTTP success' do
                expect(response).to have_http_status(:success)
            end

            # Verifica che il template di ricerca sia renderizzato correttamente
            it 'renders the search template' do
                expect(response).to render_template(:search)
            end

            # Verifica che la variabile @games sia assegnata come un array vuoto
            it 'assigns @games as an empty array' do
                expect(assigns(:games)).to eq([])
            end
        end
    end

    # Test 3: Verifica il corretto funzionamento del metodo #get_deals
    describe "GET #get_deals" do
        context "when requesting deals" do
            before do
                # Stub del metodo get_deals per simulare la richiesta di deal
                allow_any_instance_of(GamesController).to receive(:get_deals).and_return([{ 'title' => 'Deal 1' }, { 'title' => 'Deal 2' }])
                get :index
            end

            # Verifica che la richiesta HTTP abbia successo
            it 'returns HTTP success' do
              expect(response).to have_http_status(:success)
            end

            # Verifica che il template corretto venga renderizzato
            it 'renders the index template' do
                expect(response).to render_template(:index)
            end

            # Verifica che la variabile @deals sia assegnata correttamente con i deal
            it 'assigns @deals with deals data' do
                expect(assigns(:deals)).to eq([{ 'title' => 'Deal 1' }, { 'title' => 'Deal 2' }])
            end
        end
    end

    # Test 4: Verifica il corretto funzionamento del metodo #get_deals quando non ci sono deals
    describe "GET #get_deals" do
        context "when the get_deals method fails" do
            before do
                # Stub del metodo get_deals per simulare una richiesta fallita
                allow_any_instance_of(GamesController).to receive(:get_deals).and_return([])
                get :index
            end

            # Verifica che la richiesta HTTP abbia successo
            it 'returns HTTP success' do
                expect(response).to have_http_status(:success)
            end

            # Verifica che il template corretto venga renderizzato
            it 'renders the index template' do
                expect(response).to render_template(:index)
            end

            # Verifica che la variabile @deals non sia assegnata
            it 'does not assign @deals' do
                expect(assigns(:deals)).to eq([])
            end
        end
    end
end