from sqlalchemy.orm import Session
from sqlalchemy import and_, or_
import random
from sqlalchemy.sql.expression import func

from . import models, schemas

E1 = "๐๐ฅ๐ฎ๐ฎ๐ฅ๐ฆช๐๐๐๐๐๐๐๐โค๐คฃ๐คโ๐คทโโ๏ธ๐คทโโ๏ธ๐คฆโโ๏ธ๐คฆโโ๏ธ๐๐๐๐๐๐๐ข๐ถ๐๐๐ฑโ๐๐ฑโ๐ป๐ฑโ๐๐ฑโ๐ค๐คณ๐๐๐น๐ค๐โจ๐๐โ๐ฑโ๐๐ฑโ๐๐๐คข"
E2 = "๐๐๐๐๐คฃ๐๐๐๐ฅฐ๐๐๐๐๐๐๐คจ๐ค๐คฉ๐ค๐โบ๐๐๐ฎ๐ฅ๐ฃ๐๐๐ถ๐๐๐๐๐ด๐ฅฑ๐ซ๐ช๐ฏ๐ค๐๐๐๐๐๐คค๐๐"
E3 = "๐๐๐๐๐๐คค๐๐๐ค๐๐๐๐โน๐ฒ๐ค๐ฌ๐คฏ๐ฉ๐จ๐ง๐ฆ๐ญ๐ข๐ฅด๐ต๐คช๐ณ๐ฅต๐ฑ๐ฐ๐ฅถ๐ฅถ๐ณ๐คฎ๐คข๐ค๐ค๐ท๐คฌ๐ ๐ "
E4 = "๐คซ๐คฅ๐คก๐ค ๐ฅบ๐ฅณ๐๐คง๐๐บ๐น๐ฟ๐๐ค๐ง๐คญ๐ธ๐บ๐ฉ๐ค๐พ๐ฝ๐ปโ ๐ฑโ๐ค๐พ๐ฟ๐๐ฝ๐ผ๐ป๐น๐๐๐๐ฑโ๐๐ฑโ๐๐ฑโ๐๐ฑโ๐ป๐ฑโ๐๐๐ฆท๐๐๐จโ๐ฉโ๐ฆโ๐ฆ๐ฉโ๐ฉโ๐ฆ๐ฉ๐ปโ๐คโ๐ฉ๐ป๐จ๐ฟโ๐คโ๐จ๐ฟ"
E5 = "๐๐๐โจ๐งจ๐๐๐๐งง๐๐๐๐๐๐๐๐ก๐ ๐ซ๐๐๐๐๐๐๐งถ๐งต๐จ๐ผ๐ญ๐ช๐ข๐๐๐งฅ๐ฅผ๐ฅฝ๐ฆบ๐ถ๐๐๐ฅป๐๐งฆ๐งค๐งฃ๐ฉณ๐"
E_LIST = list(E1+E2+E3+E4+E5)


def fill_emoji(objects_list):
    for counter, value in enumerate(objects_list):
        if value.emoji == "":
            r_e = random.choice(E_LIST)
            if r_e == "":
                r_e = random.choice(E_LIST)
            objects_list[counter].emoji = r_e
    return objects_list


def get_backgrounds(db: Session, language_id: int):
    query = db.query(models.Background).filter(models.Background.language_id == language_id).all()
    return query

def get_random_quote_short(db: Session, author_id: int):
# ะฝะฐะนัะธ ัะปััะฐะนะฝัั ัะธัะฐัะฐ ะบะพัะพัะบะพ ะฟะพ ะฐะฒัะพัั
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

# ะฐะฒัะพัั ะฟะพ ะธะผะตะฝะธ ั ะฟะพะดััะตัะพะผ ัะธัะฐั
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

# ัะตะณะธ ะฟะพ ะฐะฒัะพัั, ัะทัะบั ั ะฟะพะดััะตัะพะผ ะบะพะป-ะฒะฐ ัะธัะฐั
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
        answer.append(schemas.Tag(**dict(r)))

    return fill_emoji(answer)

# ะฝะฐะนัะธ ัะธัะฐัั ะบะพัะพัะบะพ ะฟะพ ัะตะณั ะธ ะฐะฒัะพัั
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
