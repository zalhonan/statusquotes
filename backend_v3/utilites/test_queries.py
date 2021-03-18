from crud import models
from crud.database import SessionLocal, engine
from sqlalchemy import MetaData, Table, text
import csv
import os
from collections import OrderedDict

from crud import schemas

from utilites.utils import fill_base_with_objects

from functools import cached_property

models.Base.metadata.create_all(bind=engine)

db = SessionLocal()

а = '''Фрейд - 312
Раневская - 179
Будда - 177
Жирик - 84
Путин - 164
Кобейн - 445
'''

buddha_tags = '''
50 - люди
63 - со смыслом
221 - мысли
74 - жизнь
46 - зло
126 - страдания
'''

# найти случайную цитата коротко по языку и автору
query2 = '''
SELECT quotes.id, quotes.content
FROM quotes
WHERE quotes.language_id = :language_id 
AND quotes.author_id = :author_id
ORDER BY RANDOM() LIMIT 1
'''

a = db.execute(query2, {
    'language_id': 1,
    'author_id': 312,
    })


for i in a:
    temp_dict = dict(i)
    print('------->', temp_dict)
    # del(temp_dict["content"])
    # j = schemas.Author(**temp_dict)
    # print(j)