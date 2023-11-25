# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization



* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
api informations:
chiave api:
    b14274e8092bc14e227b32e4b66c2903bf4419c9
    
Search:
    curl -X GET "https://api.isthereanydeal.com/v01/search/search/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&q=flashback&limit=20&strict=0"

Deals:
    curl -X GET "https://api.isthereanydeal.com/v01/deals/list/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&offset=0&limit=5&region=eu2&country=CZ&shops=steam%2Cgog"

Info:
     curl -X GET "https://api.isthereanydeal.com/v01/game/info/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=forhonor"

Prices:
     curl -X GET "https://api.isthereanydeal.com/v01/game/prices/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=flashback"

Lowest:
    curl -X GET "https://api.isthereanydeal.com/v01/game/lowest/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=forhonor"

Store low:
    curl -X GET "https://api.isthereanydeal.com/v01/game/storelow/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=forhonor"

Overview:
    curl -X GET "https://api.isthereanydeal.com/v01/game/overview/?key=b14274e8092bc14e227b32e4b66c2903bf4419c9&plains=forhonor"


Search v01:
-richiede una parola
-trovi la lista che hanno quella parola nel titolo
-per ogni gioco ottieni: id, plain e title, price_new, price_old, price_cut, added, urls e shop
-parametri opzionali: limit (limiti la ricerca a x risultati) e strict (puo' essere 0 o 1 e attiva o disattiva una ricerca rigorosa)

Prices:
-richiede un plain
-trovi la lista delle informazioni sui prezzi in piu' siti,
-per ogni sito ottieni: price_new, price_old, price_cut, url, shop, drm,
-parametri opzionali: region (eu2), country (sk), shops, exlcude (escludi precisi store Example: voidu,itchio), added (timestamp, only get prices added since)

Info:
-richiede un plain
-trovi le informazioni sul gioco,
-ottieni: titolo, immagine, greenlight, is_package, is_dlc, achievements, trading cards, early access, reviews (store con percentuale positiva, numero totali, valutazione, timestamp)
-parametri opzionali: optional (Separate multiple values with comma. Possible values:  metacritic .)

Deals:
-trovi le offerte in corso
-per ogni offerta ottieni: plain, title, price_new, price_old, price_cut, added, expiry, shop, drm, urls (link alla vendita),
-parametri opzionali: offset, limit, region,country, shops, sort (time,price, cut, expiry, asc, desc)

Lowest:
-richiede un plain
-trova l'offerta piu' bassa mai registrata per quel plain
-ottieni: shop, price, cut, added, urll (di isad)
-parametri opzionali: region, country, shops, exclude, since, untill, new ( puo' essere 0 o 1 se e' 1 da i risultati dopo la data specificata)

Store low:
-richiede un plain
-trova il prezzo piu' basso registrato su ogni sito
-ottieni: shop, price
-parametri opzionali: region, country, shops, exlcude
