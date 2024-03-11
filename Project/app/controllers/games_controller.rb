require 'httparty'
class GamesController < ApplicationController
  require 'cgi'
  include GamesHelper
  include SharedHelper
  layout 'navbar_layout'
  before_action :set_api_key
  before_action :authenticate_user!, except: [:index, :show, :search, :details_game]

  def index
    @games = []
    @deals = get_deals
    @lastdeals = get_last_deals
  end

  def search
    if params[:search_query].present?
      @search_query = params[:search_query]
      @games = Rails.cache.fetch("search_results_#{@search_query}", expires_in: 1.hour) do
      search_games(@search_query, capacity: 1)
      end
      @games.each do |game|
        game['prices'] = get_game_prices(game['id'], capacity: 1)
      end
    else
      @games = []
    end
  end

  def details
    game_id = params[:id]
  
    begin
      @game_details = get_game_details(game_id)
      puts @game_details.inspect
      @game_prices = get_game_prices(game_id)  # Non specificare capacity per ottenere tutti i prezzi      @lowest_price = get_lowest_price(game_id)
  
      @game_plain = @game_details['slug']
      @comments = Comment.where(gameplain: @game_plain)
    rescue StandardError => e
      flash[:error] = "Errore nel recupero dei dettagli del gioco: #{e.message}"
      @game_details = nil
      @game_prices = nil
      @lowest_price = nil
    end
  
    @game_collection = current_user.collections.new
  end  

  def add_to_collection
    @game = Game.find_by(plain: params[:plain])
    collection_id = params[:collection_id]

    if @game && collection_id
      @game.collections << Collection.find(collection_id)
      flash[:notice] = 'Game added to collection successfully.'
    else
      flash[:error] = 'Failed to add game to collection.'
    end

    redirect_back fallback_location: root_path
  end

  private

  def set_api_key
    @api_key = 'b14274e8092bc14e227b32e4b66c2903bf4419c9'
  end
  
  def get_last_deals
    limit = 18  
    url = "https://api.isthereanydeal.com/deals/v2?key=#{@api_key}"
    url += "&country=US"
    url += "&limit=#{limit}"  
    url += "&sort=expiry"
    
    begin
      response = RestClient.get(url)
      puts "API Response (Last Deals): #{response.body}"
      parsed_response = JSON.parse(response)
      deals_data = parsed_response['list']
  
      # Per ogni deal, ottieni i dettagli completi del gioco
      deals_data.each do |deal|
        game_id = deal['id']
        game_details = get_game_details(game_id)
        # Aggiungi i dettagli del gioco al deal
        deal['game_details'] = game_details
      end
  
      return deals_data if deals_data.present?
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta dei Last Deals: #{e.response}"
    rescue => e
      puts "Errore nella richiesta dei Last Deals: #{e.message}"
    end
    
    return []
  end
  

  def get_deals
    url = "https://api.isthereanydeal.com/deals/v2?key=#{@api_key}"
  
    url += "&country=US"
    url += "&offset=#{params[:offset]}" if params[:offset].present?
    url += "&limit=#{params[:limit]}" if params[:limit].present?
    url += "&sort=#{params[:sort]}" if params[:sort].present?
    url += "&shops=#{params[:shops].join(',')}" if params[:shops].present?
    url += "&filter=#{params[:filter]}" if params[:filter].present?
  
    begin
      response = RestClient.get(url)
      puts "API Response (Deals): #{response.body}"  # Stampa la risposta nel terminale
      parsed_response = JSON.parse(response)
      deals_data = parsed_response['list']
       # Per ogni deal, ottieni i dettagli completi del gioco
       deals_data.each do |deal|
        game_id = deal['id']
        game_details = get_game_details(game_id)
        # Aggiungi i dettagli del gioco al deal
        deal['game_details'] = game_details
      end
  
      return deals_data if deals_data.present?
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta dei Last Deals: #{e.response}"
    rescue => e
      puts "Errore nella richiesta dei Last Deals: #{e.message}"
    end
    
    return []
  end
    
  def search_games(query, capacity: nil)
    url = "https://api.isthereanydeal.com/games/search/v1?key=#{@api_key}&title=#{CGI.escape(query)}"    
    url += "&capacity=#{capacity}" if capacity.present?
    response = HTTParty.get(url)

    if response.success?
      games = JSON.parse(response.body)
      games.map do |game|
        {
          'id' => game['id'],
          'slug' => game['slug'],
          'title' => game['title'],
          'type' => game['type'],
          'mature' => game['mature']
        }
      end
    else
      # Gestione degli errori, ad esempio restituendo un array vuoto
      []
    end
  end
  

  def get_game_details(id)
    details_url = "https://api.isthereanydeal.com/games/info/v2?key=#{@api_key}&id=#{id}"
  
    response = RestClient.get(details_url)
    parsed_response = JSON.parse(response)
    puts "Dettagli del gioco:"
    puts parsed_response.inspect  # Aggiungi questa linea per visualizzare i dettagli del gioco nel terminale
    parsed_response
  rescue RestClient::ExceptionWithResponse => e
    puts "Errore nella richiesta di dettagli del gioco: #{e.response}"
    {}
  rescue => e
    puts "Errore nella richiesta di dettagli del gioco: #{e.message}"
    {}
  end
  
  def get_game_prices(id, capacity: nil)
    prices_url = "https://api.isthereanydeal.com/games/prices/v2?key=#{@api_key}&nondeals=true&vouchers=true"
    game_ids = [id] # Converti l'ID del gioco in un array non vuoto

    # Aggiungi capacity alla richiesta solo se è stato specificato
    prices_url += "&capacity=#{capacity}" if capacity.present?

    response = RestClient.post(prices_url, game_ids.to_json, content_type: :json)
    parsed_response = JSON.parse(response)
    puts "Prezzi del gioco:"
    puts parsed_response.inspect  # Aggiungi questa linea per visualizzare i prezzi del gioco nel terminale
    parsed_response
  rescue RestClient::ExceptionWithResponse => e
    puts "Errore nella richiesta dei prezzi del gioco: #{e.response}"
    {}
  rescue => e
    puts "Errore nella richiesta dei prezzi del gioco: #{e.message}"
    {}
  end
  
  

  def get_lowest_price(game_plain)
    lowest_url = "https://api.isthereanydeal.com/v01/game/lowest/?key=#{@api_key}&plains=#{game_plain}"

    begin
      response = RestClient.get(lowest_url)
      parsed_response = JSON.parse(response)

      lowest_price_data = parsed_response['data'][game_plain]

      if lowest_price_data.present?
        return lowest_price_data
      else
        return {}
      end
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta del prezzo più basso: #{e.response}"
      return {}
    rescue => e
      puts "Errore nella richiesta del prezzo più basso: #{e.message}"
      return {}
    end
  end

  def store_lowest_prices
    game_plain = params[:plain]
    key = @api_key

    response = RestClient.get "https://api.isthereanydeal.com/v01/game/storelow/?key=#{key}&plains=#{game_plain}"
    data = JSON.parse(response.body)

    @lowest_prices = data.dig('data', game_plain) || []
  end

end
