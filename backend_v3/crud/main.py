from typing import List, Optional

from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session

from . import crud, models, schemas
from .database import SessionLocal, engine

from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# static files
app.mount("/images", StaticFiles(directory="images"), name="images")

origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dependency


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# некторые константы
languages = {"ru": 1, "en": 2}
max_author_id = 18735
max_tag_id = 3946
cache = {}

@app.get("/")
def glagne():
    return "Nothing to see here. Move along!"

# бекграунды по языку
@app.get("/backgrounds/", response_model=List[schemas.Background])
def get_backgrounds(language: str = 'ru', db: Session = Depends(get_db)):
    db_backgrounds = crud.get_backgrounds(db, language_id=languages.get(language, 1))
    return db_backgrounds

# короткие цитаты по id автора
@app.get("/random_quote_short/", response_model=schemas.QuoteShort)
def get_random_quote(author_id: int = 177, db: Session = Depends(get_db)):
    if author_id > max_author_id:
        author_id = 164
    random_quote = crud.get_random_quote_short(
        db,
        author_id=author_id)
    return random_quote

# авторы по имени с подсчетом цитат
@app.get("/authors_by_name/", response_model=List[schemas.Author])
def get_authors_by_name(author: str = 'Будда', db: Session = Depends(get_db)):
    authors_list = crud.get_authors_by_name(
        db,
        author=author)
    return authors_list


# теги по автору, языку с подсчетом кол-ва цитат
@app.get("/tags_by_author/", response_model=List[schemas.Tag])
def get_tags_by_author(author_id: int = 177, db: Session = Depends(get_db)):
    if author_id > max_author_id:
        author_id = 164

    cache_key = "tags_by_author_{author_id}"
    
    if cache_key in cache:
        result = cache[cache_key]    
    else:
        result = crud.get_tags_by_author(
            db,
            author_id=author_id)
        cache[cache_key] = result
    return result

# цитаты коротко по тегу и автору
@app.get("/quotes_by_tag_author/", response_model=List[schemas.QuoteShort])
def get_quotes_by_tag_author(author_id: int = 177, tag_id: int = 50, db: Session = Depends(get_db)):
    if author_id > max_author_id:
        author_id = 177
    if tag_id > max_tag_id:
        tag_id = 126

    result = crud.get_quotes_by_tag_author(
        db,
        author_id=author_id,
        tag_id=tag_id)

    return result

