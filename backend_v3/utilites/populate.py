from crud import models
from crud.database import SessionLocal, engine
from sqlalchemy import MetaData, Table
import csv
import os
from collections import OrderedDict

from utilites.utils import fill_base_with_objects

models.Base.metadata.create_all(bind=engine)

db = SessionLocal()
CSV_DIR = './csv/'

# ключи - в определенном порядке
all_keys = ("quote_tag",
            "quote_source",
            "author_section",
            "author",
            "background",
            "category",
            "description",
            "language",
            "quote",
            "section",
            "source",
            "tag")

# ключи бд, по которым сверяем не по тегу, а по полному вхождению
full_string_keys = {"quote_tag": ["quote_id", "tag_id"],
                    "quote_source": ["quote_id", "source_id"],
                    "author_section": ["author_id", "section_id"]}

# Словарь всех моделей в модуле models
all_models = {
    all_keys[0]: models.QuoteTag,
    all_keys[1]: models.QuoteSource,
    all_keys[2]: models.AuthorSection,
    all_keys[3]: models.Author,
    all_keys[4]: models.Background,
    all_keys[5]: models.Category,
    all_keys[6]: models.Description,
    all_keys[7]: models.Language,
    all_keys[8]: models.Quote,
    all_keys[9]: models.Section,
    all_keys[10]: models.Source,
    all_keys[11]: models.Tag,
}

# поля моделей, по которым сверяем дупликаты
all_checkup = {
    all_keys[0]: "",
    all_keys[1]: "",
    all_keys[2]: "",
    all_keys[3]: "name",
    all_keys[4]: "name",
    all_keys[5]: "name",
    all_keys[6]: "content",
    all_keys[7]: "code",
    all_keys[8]: "content",
    all_keys[9]: "name",
    all_keys[10]: "name",
    all_keys[11]: "name"
}

# прочитать все файлы в каталоге csv
all_csv_files = os.listdir(CSV_DIR)

# итерируемся по ключам моделей. В model_key храним текущий ключ модели
for model_key in all_keys:
    print(f"текущий model_key: {model_key}")

    # итерируемся по файлам в каталоге CSV
    for current_csv_index, current_csv in enumerate(all_csv_files):

        # убираем из названия файла "quotes" во всех вариантах
        current_csv_trimmed = current_csv.lower().replace("quotes", "")

        # находим модель, соотвествующую файлу
        if (model_key.lower() in current_csv_trimmed.lower()):
            print(
                f"данные из файла {current_csv} записываем в БД {model_key}, {all_models[model_key]}")

            all_csv_files[current_csv_index] = ""

            # открыть файл для работы
            with open(CSV_DIR + current_csv, encoding="utf8") as csv_file:
                csv_reader = csv.reader(csv_file, delimiter=',')

                # запомнить заголовки + скип заголовков
                headers = next(csv_reader)

                # заполняем временный словарик, который будем переводить в модель, ключами
                temp_dict = OrderedDict()
                for header in headers:
                    temp_dict[header] = ''

                print(f"текущий temp_dict: {temp_dict}")

                # создаем список моделей с данными
                temp_model_list = []
                for row in csv_reader:
                    for index, value in enumerate(temp_dict.keys()):
                        if value == 'id':
                            temp_dict[value] = None
                        elif "_id" in value and row[index] != '':
                            temp_dict[value] = int(row[index])
                        elif "_id" in value and row[index] == '':
                            temp_dict[value] = None
                        elif "rating" in value and row[index] == '':
                            temp_dict[value] = 0
                        else:
                            temp_dict[value] = row[index]

                    current_model = all_models[model_key](**dict(temp_dict))
                    temp_model_list.append(current_model)

                print(f"моделей в листе {len(temp_model_list)}")

                fill_base_with_objects(models_list_to_insert=temp_model_list, db_model=all_models[model_key],
                                       field_name=all_checkup[model_key], db=db,
                                       by_full_string=model_key in full_string_keys,
                                       full_string_keys=full_string_keys.get(model_key, ""))

            break


# def create_langs():

#     langs_models = [models.Language(code=code) for code in ["ru", "en", "jp"]]
#     print("Языковых моделей для БД: ", len(langs_models))
#     fill_base_with_objects(models_list_to_insert=langs_models,
#                            db_model=models.Language, field_name="code", db=db)


# create_langs()
db.close()
