from crud import models
from crud.database import SessionLocal, engine
from sqlalchemy import MetaData, Table
import csv
import os
from collections import OrderedDict

from crud import schemas

from utilites.utils import fill_base_with_objects

models.Base.metadata.create_all(bind=engine)

db = SessionLocal()

# найти автора по названию с подсчетом цитат без описания
query2 = '''
SELECT authors.*, COUNT(quotes.id) AS quotes_count
FROM authors
LEFT JOIN quotes
ON authors.id = quotes.author_id
WHERE authors.name LIKE :a_like
GROUP BY authors.id
ORDER BY quotes_count DESC
'''
print(query2)
a = db.execute(query2, {'a_like': '%Кобейн%'})   

# найти теги с подсчетом цитат по автору и языку - 8 секунд запрос
query2 = '''
SELECT tags.id, tags.name, COUNT(quote_tag.quote_id) AS quotes_count
FROM tags
LEFT JOIN quote_tag
ON tags.id = quote_tag.tag_id
LEFT JOIN quotes
ON quotes.id = quote_tag.quote_id
WHERE tags.language_id = :language_id AND quotes.author_id = :author_id
GROUP BY tags.id
ORDER BY quotes_count DESC
'''

a = db.execute(query2, {
    'language_id': 1,
    'author_id': 164,
    }) 


# найти цитаты коротко по языку, тегу и автору
query2 = '''
SELECT quotes.id, quotes.content
FROM quotes
LEFT JOIN quote_tag
ON quotes.id = quote_tag.quote_id
WHERE quotes.language_id = :language_id 
AND quotes.author_id = :author_id
AND quote_tag.tag_id = :tag_id
'''

print(query2)

a = db.execute(query2, {
    'language_id': 1,
    'author_id': 177,
    'tag_id': 50,
    })


# найти случайную цитата коротко по языку и автору коротко
query2 = '''
SELECT quotes.id, quotes.content
FROM quotes
WHERE quotes.language_id = :language_id 
AND quotes.author_id = :author_id
ORDER BY RANDOM() LIMIT 1
'''


# --------------------------------------------


# автор с описанием по языку
q_authors_and_descriptions = '''
SELECT *, descriptions.content AS description
FROM authors
LEFT JOIN descriptions
ON authors.description_id = descriptions.id
WHERE authors.language_id = :lang
'''

a = db.execute(q_authors_and_descriptions, {'lang': lang})









# найти цитаты коротко по языку и автору
query2 = '''
SELECT quotes.id, quotes.content
FROM quotes
WHERE quotes.language_id = :language_id AND quotes.author_id = :author_id
'''

print(query2)

a = db.execute(query2, {
    'language_id': 1,
    'author_id': 5,
    })