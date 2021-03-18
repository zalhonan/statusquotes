from sqlalchemy.orm import Session
from sqlalchemy import and_, or_
import random
from sqlalchemy.sql.expression import func

from . import models, schemas


def remove_descriptions(q):
    # стирание описаний при выставленном флаге description = false
    q.description_en = ""
    q.description_ru = ""
    return q


# Возвращает список секций из базы
def get_sections(db: Session, description: bool = True):
    # запросить все секции
    query = db.query(models.Section).all()
    if (description):
        return query
    else:
        return list(map(remove_descriptions, query))


def get_languages(db: Session):
    query = db.query(models.Language).all()
    return query


def get_categories(db: Session, description: bool, author_id: int):
    # сделаем выборку
    query = db.query(models.Category).all()

    quote_categories_id = [models.Quote.category1_id, models.Quote.category2_id,
                           models.Quote.category3_id, models.Quote.category4_id, models.Quote.category5_id]

    quotes_en_total = 0
    quotes_ru_total = 0

    # если передан id автора - уточнить, есть ли автор
    if author_id is not None:
        author_in_base = db.query(models.Author).filter(
            models.Author.id == author_id).first()

    # если автор есть в базе - считаем сколько цитат в категории по автору
    if author_id is not None and author_in_base is not None:
        for current_category in query:

            quotes_en_total = 0
            quotes_ru_total = 0

            for quote_category_id in quote_categories_id:
                quotes_en_count = db.query(models.Quote).filter(and_(
                    quote_category_id == current_category.id, models.Quote.language_id == 1,
                    models.Quote.author_id == author_id)).count()
                quotes_ru_count = db.query(models.Quote).filter(and_(
                    quote_category_id == current_category.id, models.Quote.language_id == 2,
                    models.Quote.author_id == author_id)).count()

                quotes_en_total += quotes_en_count
                quotes_ru_total += quotes_ru_count

            current_category.count_en = quotes_en_total
            current_category.count_ru = quotes_ru_total

    # если автора нет в базе или None - считаем по всем цитатам
    else:
        for current_category in query:

            quotes_en_total = 0
            quotes_ru_total = 0

            for quote_category_id in quote_categories_id:
                quotes_en_count = db.query(models.Quote).filter(and_(
                    quote_category_id == current_category.id, models.Quote.language_id == 1)).count()
                quotes_ru_count = db.query(models.Quote).filter(and_(
                    quote_category_id == current_category.id, models.Quote.language_id == 2)).count()

                quotes_en_total += quotes_en_count
                quotes_ru_total += quotes_ru_count

            current_category.count_en = quotes_en_total
            current_category.count_ru = quotes_ru_total

    if (description):
        return query
    else:
        return list(map(remove_descriptions, query))


def get_authors(db: Session, description: bool = True):
    query = db.query(models.Author).all()
    if (description):
        return query
    else:
        return list(map(remove_descriptions, query))


def get_backgrounds(db: Session):
    query = db.query(models.Background).all()
    return query


def get_quotes(db: Session, author_id: int, language_id: int, category_id: int, max_chars: int):

    # если передан id автора - уточнить, есть ли автор
    if author_id is not None:
        author_in_base = db.query(models.Author).filter(
            models.Author.id == author_id).first()

    # если передана категория - уточнить, есть ли категория
    if category_id is not None:
        category_in_base = db.query(models.Category).filter(
            models.Category.id == category_id).first()

    # есть автор и категория
    if author_in_base and category_in_base:
        query = db.query(models.Quote).filter(
            and_(models.Quote.language_id == language_id),
            (models.Quote.author_id == author_id),
            or_((models.Quote.category1_id == category_id),
                (models.Quote.category2_id == category_id),
                (models.Quote.category3_id == category_id),
                (models.Quote.category4_id == category_id),
                (models.Quote.category5_id == category_id))).all()

    # есть только автор
    elif author_in_base and (not category_in_base):
        query = db.query(models.Quote).filter(
            and_(models.Quote.language_id == language_id),
            (models.Quote.author_id == author_id)).all()

    # есть только категория
    elif (not author_in_base) and category_in_base:
        query = db.query(models.Quote).filter(
            and_(models.Quote.language_id == language_id),
            or_((models.Quote.category1_id == category_id),
                (models.Quote.category2_id == category_id),
                (models.Quote.category3_id == category_id),
                (models.Quote.category4_id == category_id),
                (models.Quote.category5_id == category_id))).all()

    # ничего
    else:
        query = db.query(models.Quote).filter(
            and_(models.Quote.language_id == language_id)).all()

    query = [q for q in query if len(q.content) < max_chars]

    return query


def get_random_quote(db: Session, language_id: int = 1, author_id: int = 1):
    return db.query(models.Quote).filter(and_(models.Quote.language_id == language_id,
                                              models.Quote.author_id == author_id)).order_by(func.random()).first()


def get_author_by_id(db: Session, author_id: int):
    return db.query(models.Author).filter(models.Author.id == author_id).first()
