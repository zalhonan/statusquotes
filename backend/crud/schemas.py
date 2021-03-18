from pydantic import BaseModel
from typing import Union

class Language(BaseModel):
    id: int
    code: str
    emoji: str
    name: str

    class Config:
        orm_mode = True

class Section(BaseModel):
    id: int
    emoji: str = ""
    avatar: str = ""

    name_en: str
    nameof_en: str
    description_en: str

    name_ru: str
    nameof_ru: str
    description_ru: str

    class Config:
        orm_mode = True

class Category(BaseModel):
    id: int
    emoji: str
    avatar: str = ""

    count_en: int
    name_en: str
    about_en: str
    description_en: str = ""

    count_ru: int
    name_ru: str
    about_ru: str
    description_ru: str = ""

    class Config:
        orm_mode = True

class Author(BaseModel):
    id: int
    emoji: str = ""
    avatar: str = ""

    name_en: str
    quotesof_en: str
    description_en: str

    name_ru: str
    quotesof_ru: str
    description_ru: str

    section1_id: int
    section2_id: int
    section3_id: int
    section4_id: int
    section5_id: int

    class Config:
        orm_mode = True

class Background(BaseModel):
    id: int

    name_en: str
    name_ru: str

    search: str
    folder: str
    count: int

    class Config:
        orm_mode = True

class Quote(BaseModel):
    id: int
    rating: int = 0
    content: str

    author_id: int
    language_id: int

    # author_name_ru: str
    # author_name_en: str

    category1_id: int
    category2_id: int
    category3_id: int
    category4_id: int
    category5_id: int

    class Config:
        orm_mode = True

