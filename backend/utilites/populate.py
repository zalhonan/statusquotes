import csv

from fastapi import FastAPI, HTTPException, Depends

from sqlalchemy.orm import Session

from crud import models, schemas
from crud.database import SessionLocal, engine

import os

from collections import OrderedDict

CSV_DIR = './csv/'

models.Base.metadata.create_all(bind=engine)
app = FastAPI()

# с этой базой будем работать
db = SessionLocal()

# db_quote = crud.get_quote_by_id(SessionLocal(), quote_id=1)
# print(db_quote.__dir__())
languages = {"en": 1, "ru": 2}

# Словарь всех моделей в модуле models
all_models = {
    "section": models.Section,
    "language": models.Language,
    "category": models.Category,
    "author": models.Author,
    "quote": models.Quote,
    "background": models.Background,
}

# ключевые поля моделей, по которым сверяем дупликаты
all_models_checkup_fields = {
    "section": models.Section.name_en,
    "language": models.Language.code,
    "category": models.Category.name_en,
    "author": models.Author.name_en,
    "quote": models.Quote.content,
    "background": models.Background.name_en,
}

# поля, по которым мы сверяем дубликаты
checkup_keys = {
    "section": "name_en",
    "language": "code",
    "category": "name_en",
    "author": "name_en",
    "quote": "content",
    "background": "name_en",
}


# прочитать все файлы в каталоге csv
all_csv_files = os.listdir(CSV_DIR)

# итерируемся по файлам в каталоге CSV
for current_csv in all_csv_files:

    # итерируемся по ключам моделей. В model_key храним текущий ключ модели
    for model_key in list(all_models.keys()):

        # убираем из названия файла "quotes" во всех вариантах
        current_csv_trimmed = current_csv.lower().replace("quotes", "")

        # находим модель, соотвествующую файлу
        if (model_key.lower() in current_csv_trimmed.lower()):
            print(
                f"данные из файла {current_csv} записываем в БД {model_key}, {all_models[model_key]}")

            # открыть файл для работы
            with open(CSV_DIR + current_csv, encoding="utf8") as csv_file:
                csv_reader = csv.reader(csv_file, delimiter=',')

                # запомнить заголовки + скип заголовков
                headers = next(csv_reader)

                # индекс столбца, по которому будем сверять дупликаты
                index_of_dupe_column = headers.index(checkup_keys[model_key])

                # заполняем временный словарик, который будем переводить в модель, ключами
                temp_dict = OrderedDict()
                for header in headers:
                    temp_dict[header] = ''

                # счетчики
                lines_written = 0
                lines_skipped = 0
                for row in csv_reader:
                    # текущая модель - all_models[model_key]

                    # проверка на дубликаты
                    checkup_query = db.query(all_models[model_key]).filter(
                        all_models_checkup_fields[model_key] == row[index_of_dupe_column]).all()
                    if len(checkup_query) != 0:
                        # print(
                        #     f"Запись существует: {all_models_checkup_fields[model_key]}, {row} ")
                        lines_skipped += 1
                        continue

                    # формирование модели для записи, обработка id и foreign_keys
                    for index, value in enumerate(temp_dict.keys()):
                        if value == 'id':
                            temp_dict[value] = None
                        elif "_id" in value and row[index] != '':
                            temp_dict[value] = int(row[index])
                        elif "_id" in value and row[index] == '':
                            temp_dict[value] = 0
                        elif "rating" in value and row[index] == '':
                            temp_dict[value] = 0
                        else:
                            temp_dict[value] = row[index]

                    # запись в базу
                    model_to_add = all_models[model_key](**dict(temp_dict))
                    db.add(model_to_add)
                    db.commit()
                    db.refresh(model_to_add)

                    # счетчик
                    lines_written += 1
                    if lines_written % 100 == 0:
                        print(f"текущая строка: {lines_written}")
                print(f"Всего в БД {model_key} записано строк: {lines_written}, пропущено строк: {lines_skipped}")
