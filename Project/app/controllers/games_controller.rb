class GamesController < ApplicationController
  layout 'navbar_layout'
  before_action :set_api_key
  before_action :authenticate_user!, except: [:index, :show]

  #http_basic_authenticate_with name: "user", password: "user", except: [:index, :show]


  def index
    @games = [] # O qualsiasi altra logica per ottenere i giochi desiderati
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
    rescue StandardError => e
      flash[:error] = "Errore nel recupero dei dettagli del gioco: #{e.message}"
      @game_details = nil
    end
  end

  private

  def set_api_key
    @api_key = 'b14274e8092bc14e227b32e4b66c2903bf4419c9'
  end

  def search_games
    url = "https://api.isthereanydeal.com/v02/search/search/?key=#{@api_key}&q=#{params[:search_query]}&limit=20&strict=0"

    begin
      response = RestClient.get(url)
      parsed_response = JSON.parse(response)
      game_data = parsed_response['data']['results']

      if game_data.present?
        return game_data
      else
        return []
      end
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
end

