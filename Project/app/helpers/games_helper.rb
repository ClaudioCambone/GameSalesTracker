# In app/helpers/games_helper.rb

module GamesHelper
    include ActionView::Helpers::NumberHelper
    def display_price(price)
      if price.present? && price.to_f > 0
        "€#{number_with_precision(price, precision: 2)}"
      elsez
        'N/D'
      end
    end
    
    def game_image_url(plain)
      game_info_url = "https://api.isthereanydeal.com/v01/game/info/?key=#{ENV['ITAD_API_KEY']}&plains=#{plain}"
      response = RestClient.get(game_info_url)
      parsed_response = JSON.parse(response)
      image_url = parsed_response.dig('data', plain, 'image')
      image_url.presence || placeholder_image_url # Utilizza il metodo di aiuto per ottenere l'URL placeholder se l'immagine non è disponibile
    rescue RestClient::ExceptionWithResponse, JSON::ParserError
      placeholder_image_url # Utilizza l'URL placeholder in caso di errore
    end
  
    def placeholder_image_url
      'https://via.placeholder.com/150' # URL placeholder
    end

    def game_info(plain)
      url = "https://api.isthereanydeal.com/v01/game/info/?key=#{@api_key}&plains=#{plain}"
      
      begin
        response = RestClient.get(url)
        parsed_response = JSON.parse(response)
        
        game_data = parsed_response['data'][plain]
        return {
          'title' => game_data['title'],
          'image_url' => game_data['image'],
          'game_url' => game_data['urls']['game']
        }
      rescue RestClient::ExceptionWithResponse => e
        puts "Errore nella richiesta: #{e.response}"
        return {}
      rescue => e
        puts "Errore: #{e.message}"
        return {}
      end
    end

    def display_percent(value)
      if value.present?
        "#{value}%"
      else
        'N/D'
      end
    end
  
    def display_boolean(value)
      value.present? ? (value ? 'Yes' : 'No') : 'N/D'
    end
  
    def display_review(review)
      if review.present?
        "Steam Review: #{review['text']} (#{review['perc_positive']}% positive, #{review['total']} reviews)"
      else
        'N/D'
      end
    end
  
    def display_urls(urls)
      if urls.present?
        urls.map { |type, url| "#{type.capitalize}: #{link_to(type.capitalize, url)}" }.join(', ')
      else
        'N/D'
      end
    end
  end
  