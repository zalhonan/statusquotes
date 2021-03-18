from fastapi import FastAPI
from sqlalchemy.orm import Session
from sqlalchemy import and_

from crud import models
from crud.database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependency


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# db_quote = crud.get_quote_by_id(SessionLocal(), quote_id=1)
# print(db_quote.__dir__())
languages = {"en": 1, "ru": 2}


def count_quotes_in_category(db: Session):
    categories_count = db.query(models.Category).count()
    print('---starting counting categories---')
    print(
        f"total categories: {categories_count}. Counting quotes in categories...")
    for i in range(1, categories_count + 1):
        current_category = db.query(models.Category).get(i)
        print(
            f"current cat: {current_category.id}. {current_category.name_en} / {current_category.name_ru}")
        print(
            f"current count: en: {current_category.count_en}, ru: {current_category.count_ru}")

        quotes_en_count = db.query(models.Quote).filter(and_(
            models.Quote.category_id == current_category.id, models.Quote.language_id == 1)).count()
        quotes_ru_count = db.query(models.Quote).filter(and_(
            models.Quote.category_id == current_category.id, models.Quote.language_id == 2)).count()
        current_category.count_en = quotes_en_count
        current_category.count_ru = quotes_ru_count
        db.commit()

        print(
            f"updated count: en: {current_category.count_en}, ru: {current_category.count_ru}")


count_quotes_in_category(SessionLocal())

# db_category = models.Category(
#     name_en=category.name_en, name_ru=category.name_ru)

#     checkup_category = db.query(models.Category).filter(
#         models.Category.name_en == category.name_en).all()
#     if len(checkup_category) != 0:
#         print(
#             f'Category exists {checkup_category[0].name_en}, count: {len(checkup_category)}')
#         return db_category

#     db.add(db_category)
#     db.commit()
#     db.refresh(db_category)
#     return db_category


# with open('categories.csv', encoding="utf8") as csv_file:
#     csv_reader = csv.reader(csv_file, delimiter=',')
#     line_count = 0
#     for row in csv_reader:
#         print(f'current row: {row}')
#         newcategory = schemas.Category(name_en=row[0], name_ru=row[1], id=0)
#         create_category(SessionLocal(), newcategory)
