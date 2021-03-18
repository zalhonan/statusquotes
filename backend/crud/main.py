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


# db_quote = crud.get_quote_by_id(SessionLocal(), quote_id=1)
# print(db_quote.__dir__())
languages = {"en": 1, "ru": 2}


@app.get("/")
def glagne():
    return "Nothing to see here. Move along!"


@app.get("/sections/", response_model=List[schemas.Section])
def get_sections(description: bool = True, db: Session = Depends(get_db)):
    db_sections = crud.get_sections(db, description=description)
    return db_sections


@app.get("/languages/", response_model=List[schemas.Language])
def get_languages(db: Session = Depends(get_db)):
    db_language = crud.get_languages(db)
    return db_language


@app.get("/categories/", response_model=List[schemas.Category])
def get_categoies(description: bool = True, db: Session = Depends(get_db), author_id: Optional[int] = None):
    db_categories = crud.get_categories(
        db, description=description, author_id=author_id)
    return db_categories


@app.get("/authors/", response_model=List[schemas.Author])
def get_authors(description: bool = True, db: Session = Depends(get_db)):
    db_authors = crud.get_authors(db, description=description)
    return db_authors

@app.get("/backgrounds/", response_model=List[schemas.Background])
def get_backgrounds(db: Session = Depends(get_db)):
    db_backgrounds = crud.get_backgrounds(db)
    return db_backgrounds


@app.get("/quotes/", response_model=List[schemas.Quote])
def get_quotes(language: str = 'en', author_id: int = 1, category_id: int = 1,
               max_chars: int = 2000, db: Session = Depends(get_db)):
    db_quotes = crud.get_quotes(
        db=db, language_id=languages[language], author_id=author_id, category_id=category_id, max_chars=max_chars)
    return db_quotes


@app.get("/random_quote/", response_model=schemas.Quote)
def get_random_quote(language: str = "en", author_id: int = 1, db: Session = Depends(get_db)):
    random_quote = crud.get_random_quote(
        db,
        language_id=languages[language],
        author_id=author_id)
    return random_quote


@app.get("/author_by_id/", response_model=schemas.Author)
def get_author_by_id(author_id: int = 1, db: Session = Depends(get_db)):
    return crud.get_author_by_id(db=db, author_id=author_id)
