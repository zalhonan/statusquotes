from sqlalchemy.orm import Session
from sqlalchemy import and_, or_
import random
from sqlalchemy.sql.expression import func

from . import models, schemas

def get_backgrounds(db: Session, language_id: int):
    query = db.query(models.Background).filter(models.Background.language_id == language_id).all()
    return query

def get_random_quote_short(db: Session, author_id: int):
# найти случайную цитата коротко по автору
    query = '''
    SELECT quotes.id, quotes.content, authors.name AS author
    FROM quotes
    LEFT JOIN authors
    ON quotes.author_id = authors.id
    WHERE quotes.author_id = :author_id
    ORDER BY RANDOM() LIMIT 1
    '''

    response = db.execute(query, {
    'author_id': author_id,
    })

    result = response.next()

    return schemas.QuoteShort(**dict(result))

# авторы по имени с подсчетом цитат
def get_authors_by_name(db: Session, author: str):
    query = '''
    SELECT authors.*, COUNT(quotes.id) AS quotes_count
    FROM authors
    LEFT JOIN quotes
    ON authors.id = quotes.author_id
    WHERE authors.name LIKE :a_like
    GROUP BY authors.id
    ORDER BY quotes_count DESC
    '''

    response = db.execute(query, {'a_like': f'%{author}%'})
    answer = []
    for r in response:
        answer.append(schemas.Author(**dict(r)))

    return answer

# теги по автору, языку с подсчетом кол-ва цитат
def get_tags_by_author(db: Session, author_id: int):

    query = '''
    SELECT tags.*, COUNT(quote_tag.quote_id) AS count
    FROM tags
    LEFT JOIN quote_tag
    ON tags.id = quote_tag.tag_id
    LEFT JOIN quotes
    ON quotes.id = quote_tag.quote_id
    WHERE quotes.author_id = :author_id
    GROUP BY tags.id
    ORDER BY count DESC
    '''

    response = db.execute(query, {
        'author_id': author_id, })

    answer = []
    for r in response:
        # print('------>', dict(r))
        answer.append(schemas.Tag(**dict(r)))

    return answer

# найти цитаты коротко по тегу и автору
def get_quotes_by_tag_author(db: Session, author_id: int, tag_id: int):

    query = '''
    SELECT quotes.id, quotes.content, authors.name AS author
    FROM quotes
    LEFT JOIN quote_tag
    ON quotes.id = quote_tag.quote_id
    LEFT JOIN authors
    ON quotes.author_id = authors.id
    WHERE quotes.author_id = :author_id
    AND quote_tag.tag_id = :tag_id
    '''
    
    response = db.execute(query, {
        'author_id': author_id,
        'tag_id': tag_id, })

    answer = []
    for r in response:
        # print('------>', dict(r))
        answer.append(schemas.QuoteShort(**dict(r)))

    return answer
