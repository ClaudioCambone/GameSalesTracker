module SharedHelper
  require 'httparty'

  def game_info(id)
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
  
end
