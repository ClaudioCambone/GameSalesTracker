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
  