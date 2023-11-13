class SteamApi
  require 'net/http'
  require 'cgi'
  require 'uri'

  def initialize
    @url_base = "https://steam2.p.rapidapi.com/"
    @http = Net::HTTP.new(URI(@url_base).host, URI(@url_base).port)
    @http.use_ssl = true
  end

  def search(game_name)
    game_name_encoded = URI.encode_www_form('search' => game_name)
    puts "Game name: #{game_name}"
    puts "Encoded game name: #{game_name_encoded}"
    
    url = URI("#{@url_base}/#{game_name_encoded}")
    url = URI("https://steam2.p.rapidapi.com/search/for%20honor/page/1")
    puts "URL: #{url}"
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '0035a6aeedmshf67c280deef2946p154266jsn9f8edec06fc1'
    request["X-RapidAPI-Host"] = 'steam2.p.rapidapi.com'
  
    begin
      response = @http.request(request)
      puts "Response body: #{response.body}"
  
      # Verify that the response body is valid JSON
      begin
        @games = JSON.parse(response.body)
        puts @games.inspect
      rescue JSON::ParserError => e
        puts "Received invalid JSON: #{e}"
        @games = nil
      end
  
    rescue => e
      puts "Error: #{e}"
    end
  end
  


  

  def app_detail(app_id)
    url = URI(@url_base + "appDetail/#{app_id}")
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '0035a6aeedmshf67c280deef2946p154266jsn9f8edec06fc1'
    request["X-RapidAPI-Host"] = 'steam2.p.rapidapi.com'
    
    response = @http.request(request)
    JSON.parse(response.body)
  end
end

  