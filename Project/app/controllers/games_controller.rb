class GamesController < ApplicationController
  include GamesHelper
  layout 'navbar_layout'
  before_action :set_api_key
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @games = []
    @deals = get_deals
  end

  def search
    if params[:search_query].present?
      @search_query = params[:search_query]
      @games = search_games
    else
      @games = []
    end
  end  

  def details
    game_plain = params[:plain]
  
    begin
      @game_details = get_game_details([game_plain])
      @game_prices = get_game_prices(game_plain)
      @lowest_price = get_lowest_price(game_plain)
      store_lowest_prices

      @game_plain = game_plain
  
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

  def get_deals
    url = "https://api.isthereanydeal.com/v01/deals/list/?key=#{@api_key}&offset=0&limit=12"
  
    begin
      response = RestClient.get(url)
      parsed_response = JSON.parse(response)
      deals_data = parsed_response['data']['list']
      deals_data.each do |deal|
        plain = deal['plain']
        game_info = game_info(plain)
        deal['image_url'] = game_info['image_url'] if game_info.present?
      end
  
      return deals_data if deals_data.present?
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta dei Deals: #{e.response}"
    rescue => e
      puts "Errore nella richiesta dei Deals: #{e.message}"
    end
  
    return []
  end
  

  def search_games
    url = "https://api.isthereanydeal.com/v01/search/search/?key=#{@api_key}&q=#{params[:search_query]}&limit=12&strict=0"
    
    begin
      response = RestClient.get(url)
      parsed_response = JSON.parse(response)
    
      game_data = parsed_response['data']['list']
  
      @prezzi_attuali_inferiori = {}
      game_data.each do |game|
        plain = game['plain']
        if @prezzi_attuali_inferiori.key?(plain)
          @prezzi_attuali_inferiori[plain] = [game['price_new'].to_f, @prezzi_attuali_inferiori[plain]].min
        else
          @prezzi_attuali_inferiori[plain] = game['price_new'].to_f
        end
      end
  
      game_data.each do |game|
        game['price_new'] = @prezzi_attuali_inferiori[game['plain']].to_s
        game['image_url'] = game_image_url(game['plain'])
        
        # Aggiunta per ottenere le informazioni dettagliate del gioco
        game_info = game_info(game['plain'])
        game.merge!(game_info) if game_info.present?
      end
      
      lowest_price = Float::INFINITY
      lowest_price_game = nil
  
      game_data.each do |game|
        price_new = game['price_new'].to_f
        if price_new < lowest_price
          lowest_price = price_new
          lowest_price_game = game
        end
      end
      
      @lowest_price_game = lowest_price_game if lowest_price_game.present?
  
      return game_data
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta: #{e.response}"
      return []
    rescue => e
      puts "Errore: #{e.message}"
      return []
    end
  end

  def get_game_details(game_plains)
    details_url = "https://api.isthereanydeal.com/v01/game/info/?key=#{@api_key}&plains=#{game_plains.join(',')}"

    response = RestClient.get(details_url)
    parsed_response = JSON.parse(response)
    game_details = parsed_response['data']

    if game_details.present?
      prices_url = "https://api.isthereanydeal.com/v01/game/prices/?key=#{@api_key}&plains=#{game_plains.join(',')}"
      prices_response = RestClient.get(prices_url)
      prices_data = JSON.parse(prices_response)['data']

      @prices = prices_data.values if prices_data.present?

      return game_details
    else
      return []
    end
  rescue RestClient::ExceptionWithResponse => e
    puts "Errore nella richiesta di dettagli dei giochi: #{e.response}"
    return []
  rescue => e
    puts "Errore nella richiesta di dettagli dei giochi: #{e.message}"
    return []
  end

  def get_game_prices(game_plain)
    prices_url = "https://api.isthereanydeal.com/v01/game/prices/?key=#{@api_key}&plains=#{game_plain}"

    begin
      response = RestClient.get(prices_url)
      parsed_response = JSON.parse(response)

      game_prices = parsed_response['data'][game_plain]

      if game_prices.present?
        return game_prices
      else
        return []
      end
    rescue RestClient::ExceptionWithResponse => e
      puts "Errore nella richiesta di prezzi del gioco: #{e.response}"
      return []
    rescue => e
      puts "Errore nella richiesta di prezzi del gioco: #{e.message}"
      return []
    end
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