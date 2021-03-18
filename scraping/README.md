# Парсеры цитат

### citaty.info

#### Это скромный парсер, но он делает свою работу

##### Работает очень неоптимально, использовать осторожно

##### Проходит последовательно по всем URL сайта с цитатами и забирает верхнюю цитату по xpath

- в файле `citaty_info_seq.py` установить `start_url` и `end_url`
- `scrapy crawl --set FEED_EXPORT_ENCODING=utf-8 --nolog citaty_seq -o output.json`