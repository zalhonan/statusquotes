from pydantic import BaseModel
from typing import Union, Optional


class Background(BaseModel):
    id: int
    name: str
    search: str
    folder: str
    count: int

    class Config:
        orm_mode = True


class QuoteShort(BaseModel):
    id: int
    content: str
    author: str

    class Config:
        orm_mode = True


class Author(BaseModel):
    id: int
    emoji: str = ""
    avatar: str = ""
    name: str
    about: str
    quotes_count: Optional[int]
    description: Optional[str]

    class Config:
        orm_mode = True


class Tag(BaseModel):
    id: int
    emoji: str = ""
    avatar: str = ""
    name: str
    about: str
    count: Optional[int]
    description: Optional[str]

    class Config:
        orm_mode = True


class Version(BaseModel):
    version: str
    date: str
