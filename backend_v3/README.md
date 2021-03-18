использование, v3

- conda activate web38 // активация окружения
- python fill_base.py // создать базы, csv -> БД, дубликаты пропускаются
- python fill_previews.py // создать превьюшки картинок 100х100
- uvicorn crud.main:app --reload // создать БД, поднять тест сервер
----------
- python test_q (поправить utilites/test_queries.py) - тестовые запросы к базе
- `database_full_explore.ipynb` - исследование наскрапленного датасета и создание таблиц

Деплой
https://statusquoteseu3.herokuapp.com/

Документация:
- https://statusquoteseu3.herokuapp.com/docs
- https://statusquoteseu3.herokuapp.com/redoc

---------

- аплоад на хероку (подробно в инстансе на хероку):

>$ git add .
>$ git commit -am "make it better"
>$ git push heroku master

