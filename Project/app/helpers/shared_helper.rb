module SharedHelper
    
    def game_info(plain)
        url = "https://api.isthereanydeal.com/v01/game/info/?key=#{@api_key}&plains=#{plain}"
      
        begin
          response = RestClient.get(url)
          parsed_response = JSON.parse(response)
      
          game_data = parsed_response['data'][plain]
          
          return {
            'title' => game_data['title'],
            'image_url' => game_data['image'],
          } if game_data.present?
        rescue RestClient::ExceptionWithResponse => e
          puts "Errore nella richiesta di informazioni del gioco: #{e.response}"
        rescue => e
          puts "Errore nella richiesta di informazioni del gioco: #{e.message}"
        end
      
        return {}
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
end