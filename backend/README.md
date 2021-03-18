использование, v2

- conda activate web38 // активация окружения
- python fill_base.py // создать базы, csv -> БД, дубликаты пропускаются
- uvicorn crud.main:app --reload // создать БД, поднять тест сервер

----------


Деплой
https://statusquoteseu2.herokuapp.com/

Документация:
- https://statusquoteseu2.herokuapp.com/docs
- https://statusquoteseu2.herokuapp.com/redoc

---------

- аплоад на хероку (подробно в инстансе на хероку):

>$ git add .
>$ git commit -am "make it better"
>$ git push heroku master

