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

