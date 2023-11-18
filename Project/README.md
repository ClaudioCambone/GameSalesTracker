# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization


Api information: 

-chiave api:
    b14274e8092bc14e227b32e4b66c2903bf4419c9
-comando curl per la search:
    curl -X GET "https://api.isthereanydeal.com/v02/search/search/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&q=naruto&limit=20&strict=0"
-risultati comando curl per la search:
    {"data":{"results":[{"id":95132833,"plain":"narutotobarutoshinobistriker","title":"Naruto to Baruto: Shinobi Striker"},{"id":992324722,"plain":"narutocollection","title":"NARUTO Collection"},{"id":70992,"plain":"narutofx","title":"NARUTO FX"},{"id":1091657506,"plain":"dragonballvsnaruto","title":"Dragonball vs naruto"},{"id":715371160,"plain":"narutoninjabattle","title":"Naruto ninja battle"},{"id":47482,"plain":"narutoultimateninjastorm","title":"NARUTO: Ultimate Ninja STORM"},{"id":114553,"plain":"narutoshippudenultimateninjastorm","title":"Naruto Shippuden Ultimate Ninja STORM"},{"id":120214,"plain":"narutotoborutoshinobistriker","title":"Naruto to Boruto Shinobi Striker"},{"id":154417,"plain":"narutoultimateninjastormii","title":"NARUTO: Ultimate Ninja STORM 2"},{"id":175388,"plain":"narutoshippudenultimateninjastormiv","title":"Naruto Shippuden: Ultimate Ninja Storm 4"},{"id":755990324,"plain":"narutotoborutoshinobistrikerus","title":"Naruto to Boruto: Shinobi Striker (US)"},{"id":143403,"plain":"narutoshippudenultimateninjastormii","title":"NARUTO SHIPPUDEN: Ultimate Ninja STORM 2"},{"id":152083,"plain":"narutoshippudenultimateninjastormtrilogy","title":"NARUTO SHIPPUDEN: Ultimate Ninja STORM Trilogy"},{"id":169612,"plain":"narutoshippudenultimateninjastormrevolution","title":"NARUTO SHIPPUDEN: Ultimate Ninja STORM Revolution"},{"id":115997,"plain":"narutoshippudenultimateninjastormlegacy","title":"NARUTO SHIPPUDEN: Ultimate Ninja STORM Legacy"},{"id":856766990,"plain":"narutoshippudenultimateninjastormivus","title":"Naruto Shippuden : Ultimate Ninja Storm 4 (US)"},{"id":1097685397,"plain":"narutotoborutoshinobistrikerultimateedition","title":"NARUTO TO BORUTO: SHINOBI STRIKER Ultimate Edition"},{"id":114856,"plain":"narutoshippudenultimateninjastormiiihd","title":"Naruto Shippuden Ultimate Ninja STORM 3 HD"},{"id":79057,"plain":"narutotoborutoshinobistrikerdeluxeedition","title":"Naruto to Boruto Shinobi Striker - Deluxe Edition"},{"id":856766991,"plain":"narutoshippudenultimateninjastormrevolutionus","title":"Naruto Shippuden Ultimate Ninja Storm Revolution (US)"}],"urls":{"search":"https:\/\/isthereanydeal.com\/search\/?q=naruto"}}}
-comando curl per i deals:
    curl -X GET "https://api.isthereanydeal.com/v01/deals/list/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&offset=0&limit=5&region=eu2&country=CZ&shops=steam%2Cgog"
-risultati comando curl per i deals:
    {".meta":{"currency":"EUR"},"data":{"count":83461,"list":[{"plain":"multiplayercavemen","title":"MULTIPLAYER CAVEMEN","price_new":0.69,"price_old":0.99,"price_cut":30,"added":1700297290,"expiry":1700935200,"shop":{"id":"steam","name":"Steam"},"drm":["steam"],"urls":{"buy":"https:\/\/store.steampowered.com\/app\/2681180\/","game":"https:\/\/isthereanydeal.com\/game\/multiplayercavemen\/info\/"}},{"plain":"allarchorgamesonsteam","title":"ALL ARCHOR GAMES ON STEAM","price_new":41.16,"price_old":44.55,"price_cut":8,"added":1700297290,"expiry":null,"shop":{"id":"steam","name":"Steam"},"drm":[],"urls":{"buy":"https:\/\/store.steampowered.com\/bundle\/27657\/","game":"https:\/\/isthereanydeal.com\/game\/allarchorgamesonsteam\/info\/"}},{"plain":"heianzhireniiheianshengjianchuanshuo","title":"\u9ed1\u6697\u4e4b\u52032\uff08\u9ed1\u6697\u5723\u5251\u4f20\u8bf4\uff09","price_new":19.6,"price_old":24.5,"price_cut":20,"added":1700297287,"expiry":1700935200,"shop":{"id":"steam","name":"Steam"},"drm":["steam"],"urls":{"buy":"https:\/\/store.steampowered.com\/app\/2653300\/","game":"https:\/\/isthereanydeal.com\/game\/heianzhireniiheianshengjianchuanshuo\/info\/"}},{"plain":"feihualingxiatiandeludougao","title":"\u98db\u82b1\u4ee4~\u590f\u5929\u7684\u7da0\u8c46\u7cd5","price_new":0.49,"price_old":0.99,"price_cut":51,"added":1700295491,"expiry":1701540000,"shop":{"id":"steam","name":"Steam"},"drm":["steam"],"urls":{"buy":"https:\/\/store.steampowered.com\/app\/2314890\/","game":"https:\/\/isthereanydeal.com\/game\/feihualingxiatiandeludougao\/info\/"}},{"plain":"feihualingchunbing","title":"\u98de\u82b1\u4ee4 \u6625\u997c","price_new":0.49,"price_old":0.99,"price_cut":51,"added":1700295491,"expiry":1701540000,"shop":{"id":"steam","name":"Steam"},"drm":["steam"],"urls":{"buy":"https:\/\/store.steampowered.com\/app\/1511360\/","game":"https:\/\/isthereanydeal.com\/game\/feihualingchunbing\/info\/"}}],"urls":{"deals":"https:\/\/isthereanydeal.com\/"}}
comando curl per info gioco:
     curl -X GET "https://api.isthereanydeal.com/v01/game/info/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=multiplayercavemen,allarchorgamesonsteam,heianzhireniiheianshengjianchuanshuo,feihualingxiatiandeludougao,feihualingchunbing"
risultati comando curl per le info:
     {"data":{"multiplayercavemen":{"title":"MULTIPLAYER CAVEMEN","image":null,"greenlight":null,"is_package":false,"is_dlc":false,"achievements":false,"trading_cards":false,"early_access":false,"reviews":null,"urls":{"game":"https:\/\/isthereanydeal.com\/game\/multiplayercavemen\/info\/","history":"https:\/\/isthereanydeal.com\/game\/multiplayercavemen\/history\/","package":"https:\/\/isthereanydeal.com\/game\/multiplayercavemen\/info\/","dlc":"https:\/\/isthereanydeal.com\/game\/multiplayercavemen\/info\/"}},"allarchorgamesonsteam":{"title":"ALL ARCHOR GAMES ON STEAM","image":null,"greenlight":null,"is_package":true,"is_dlc":false,"achievements":false,"trading_cards":false,"early_access":false,"reviews":null,"urls":{"game":"https:\/\/isthereanydeal.com\/game\/allarchorgamesonsteam\/info\/","history":"https:\/\/isthereanydeal.com\/game\/allarchorgamesonsteam\/history\/","package":"https:\/\/isthereanydeal.com\/game\/allarchorgamesonsteam\/info\/","dlc":"https:\/\/isthereanydeal.com\/game\/allarchorgamesonsteam\/info\/"}},"heianzhireniiheianshengjianchuanshuo":{"title":"\u9ed1\u6697\u4e4b\u52032\uff08\u9ed1\u6697\u5723\u5251\u4f20\u8bf4\uff09","image":null,"greenlight":null,"is_package":false,"is_dlc":false,"achievements":false,"trading_cards":false,"early_access":false,"reviews":null,"urls":{"game":"https:\/\/isthereanydeal.com\/game\/heianzhireniiheianshengjianchuanshuo\/info\/","history":"https:\/\/isthereanydeal.com\/game\/heianzhireniiheianshengjianchuanshuo\/history\/","package":"https:\/\/isthereanydeal.com\/game\/heianzhireniiheianshengjianchuanshuo\/info\/","dlc":"https:\/\/isthereanydeal.com\/game\/heianzhireniiheianshengjianchuanshuo\/info\/"}},"feihualingxiatiandeludougao":{"title":"\u98db\u82b1\u4ee4~\u590f\u5929\u7684\u7da0\u8c46\u7cd5","image":"https:\/\/steamcdn-a.akamaihd.net\/steam\/apps\/2314890\/header.jpg","greenlight":null,"is_package":false,"is_dlc":false,"achievements":false,"trading_cards":false,"early_access":false,"reviews":null,"urls":{"game":"https:\/\/isthereanydeal.com\/game\/feihualingxiatiandeludougao\/info\/","history":"https:\/\/isthereanydeal.com\/game\/feihualingxiatiandeludougao\/history\/","package":"https:\/\/isthereanydeal.com\/game\/feihualingxiatiandeludougao\/info\/","dlc":"https:\/\/isthereanydeal.com\/game\/feihualingxiatiandeludougao\/info\/"}},"feihualingchunbing":{"title":"\u98de\u82b1\u4ee4 \u6625\u997c","image":"https:\/\/steamcdn-a.akamaihd.net\/steam\/apps\/1511360\/header.jpg","greenlight":null,"is_package":false,"is_dlc":false,"achievements":false,"trading_cards":false,"early_access":false,"reviews":null,"urls":{"game":"https:\/\/isthereanydeal.com\/game\/feihualingchunbing\/info\/","history":"https:\/\/isthereanydeal.com\/game\/feihualingchunbing\/history\/","package":"https:\/\/isthereanydeal.com\/game\/feihualingchunbing\/info\/","dlc":"https:\/\/isthereanydeal.com\/game\/feihualingchunbing\/info\/"}}}}


* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
