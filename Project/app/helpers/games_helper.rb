# In app/helpers/games_helper.rb

module GamesHelper
    include ActionView::Helpers::NumberHelper
    def display_price(price)
      if price.present? && price.to_f > 0
        "€#{number_with_precision(price, precision: 2)}"
      else
        'N/D'
      end
    end    
    
    def game_image_url(plain)
      game_info_url = "https://api.isthereanydeal.com/v01/game/info/?key=#{ENV['ITAD_API_KEY']}&plains=#{plain}"
      response = RestClient.get(game_info_url)
      parsed_response = JSON.parse(response)
      image_url = parsed_response.dig('data', plain, 'image')
      image_url.presence || placeholder_image_url
    rescue RestClient::ExceptionWithResponse, JSON::ParserError
      placeholder_image_url
    end    

    def game_image_tag(image_url)
      if image_url.present?
        image_tag(image_url, class: "img-thumbnail", alt: "Game Image")
      else
        image_tag(placeholder_image_url, class: "img-thumbnail", alt: "Placeholder Image")
      end
    end
    
    def placeholder_image_url
      ActionController::Base.helpers.asset_path('placeholder.png')
    end             

    def display_boolean(value)
      value.present? ? (value ? 'Yes' : 'No') : 'N/D'
    end
    
  
    def display_percent(value)
      value.present? ? "#{value}%" : 'N/D'
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

    def deal_title(deal)
      link_to deal['title'], details_game_path(plain: deal['plain'])
    end

    def formatted_price(price)
      "€ #{'%.2f' % price}" if price.present?
    end

    def formatted_time(time)
      if time.present?
        parsed_time = Time.parse(time)
        parsed_time.strftime("%Y-%m-%d %H:%M")
      else
        'Data non disponibile'
      end
    end       

    def formatted_expiry(expiry)
      expiry.present? ? Time.at(expiry).strftime("%Y-%m-%d %H:%M:%S") : 'Expiry non disponibile'
    end

    def countdown_to_end_date(end_date)
      return '--' unless end_date
      
      remaining_time = end_date.to_i - Time.now.to_i
      
      if remaining_time.negative?
        return 'ended'
      end
    
      days = remaining_time / 1.day
      hours = (remaining_time % 1.day) / 1.hour
      minutes = (remaining_time % 1.hour) / 1.minute
      seconds = remaining_time % 1.minute
    
      "#{days.to_i} d #{hours} h #{minutes} m #{seconds} s"
    end    

  def game_image_tag(image_url, options = {})
    options[:class] ||= ''
    options[:class] += ' card-img-top img-fluid'
    options[:alt] ||= 'Game Image'
    image_tag(image_url.presence || 'placeholder.png', options)
  end

  def calculate_cut(price, regular_price)
    cut = ((regular_price.to_f - price.to_f) / regular_price.to_f * 100).round(2)
    "#{cut}%"
  end

  def score_color_class(score)
    if score.present? && score >= 75
      'high-score'
    elsif score.present? && score >= 50
      'medium-score'
    elsif score.present?
      'low-score'
    else
      # Gestione nel caso in cui score sia nullo
      'default-score'
    end
  end
end
  