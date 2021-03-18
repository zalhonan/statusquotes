import scrapy
from scrapy.http import HtmlResponse
from bs4 import BeautifulSoup

# scrapy crawl --set FEED_EXPORT_ENCODING=utf-8 --nolog citaty_seq -o output.json

# scrapy runspider --set FEED_EXPORT_ENCODING=utf-8 .\TheScrapyScript.py -o TheOutputFile.json
# scrapy crawl --set FEED_EXPORT_ENCODING=utf-8 citaty_seq -o 1-10.json
# LOG_ENABLED=False
# --nolog

class QuotesSpider(scrapy.Spider):
    name = "citaty_seq"

    start_url = 10001
    end_url = 20000
    all_urls = ['https://citaty.info/quote/' + str(i) for i in range(start_url, end_url + 1)]

    def start_requests(self):
        urls = self.all_urls
        for url in urls:
            current = int(str(url).split('/')[-1])
            if current % 100 == 0:
                print('------------>parsing', current)
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        mainquote = response.xpath("//div[contains(@class, 'node__content')]")[0]
        mainquote_string = mainquote.get()
        mainquote_only = HtmlResponse(url="oops", body=mainquote_string, encoding='utf-8')

        text_source = mainquote_only.xpath("//div[contains(@class, 'field-item') and contains(@class, 'even') and contains(@class, 'last')]//p").get()
        soup = BeautifulSoup(text_source)
        text_final = soup.get_text()
        text_final = text_final.replace('\xa0', ' ')

        yield {
            'url': str(response),
            'text': text_final,
            'author': mainquote_only.xpath("//div[contains(@class, 'field-name-field-book-author')]//div//div//a/text()").get(),
            'author2': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-3')]//div//div//a/text()").get(),
            'book': mainquote_only.xpath("//div[contains(@class, 'field-name-field-book-title')]//div//div//a/text()").get(),
            'characters': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-6')]//div//div//a/text()").getall(),
            'tags': mainquote_only.xpath("//div[contains(@class, 'node__topics')]//div//div//div//a/text()").getall(),
            'movie': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-4')]//div//div//a/text()").get(),
            'anime': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-24')]//div//div//a/text()").get(),
            'series': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-25')]//div//div//a/text()").get(),
            'season': mainquote_only.xpath("//div[contains(@class, 'field-name-field-season')]//div//div//a/text()").get(),
            'episode': mainquote_only.xpath("//div[contains(@class, 'field-name-field-series')]//div//div//a/text()").get(),
            'band': mainquote_only.xpath("//div[contains(@class, 'field-name-field-band')]//div//div//a/text()").get(),
            'song': mainquote_only.xpath("//div[contains(@class, 'field-name-field-song')]//div//div//a/text()").get(),
            'game': mainquote_only.xpath("//div[contains(@class, 'field-name-taxonomy-vocabulary-12')]//div//div//a/text()").get(),
        }

