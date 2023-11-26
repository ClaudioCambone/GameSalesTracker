class GameInfoJob < ApplicationJob
    queue_as :default
  
    def perform(plain)
      game_info = fetch_game_info(plain)
  
      # Aggiorna il modello del gioco o la cache con le nuove informazioni
      # Puoi scegliere come gestire le informazioni ricevute
      GameInfoCache.update_info(plain, game_info)
    end
  
    private
  
    def fetch_game_info(plain)
      # La tua logica per chiamare l'API delle informazioni del gioco
    end
  end
  