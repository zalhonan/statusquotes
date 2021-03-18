from sqlalchemy import Column, ForeignKey, Integer, String, Text
from sqlalchemy.orm import relationship

from .database import Base


class Language(Base):
    __tablename__ = "languages"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(length=50), unique=True, index=True)
    name = Column(String(length=50), unique=True, index=True)
    emoji = Column(String(length=50), default="")

    quotes = relationship("Quote", back_populates="languages")

class Section(Base):
    __tablename__ = "sections"

    id = Column(Integer, primary_key=True, index=True)
    emoji = Column(String(length=50), default="")
    avatar = Column(String(100), default="")

    name_en = Column(String(length=100), default="")
    nameof_en = Column(String(length=100), default="")
    description_en = Column(Text(), default="")

    name_ru = Column(String(length=100), default="")
    nameof_ru = Column(String(length=100), default="")
    description_ru = Column(Text(), default="")

    author_sec1 = relationship(
        "Author", backref="sec1", lazy="dynamic", foreign_keys="Author.section1_id")
    author_sec2 = relationship(
        "Author", backref="sec2", lazy="dynamic", foreign_keys="Author.section2_id")
    author_sec3 = relationship(
        "Author", backref="sec3", lazy="dynamic", foreign_keys="Author.section3_id")
    author_sec4 = relationship(
        "Author", backref="sec4", lazy="dynamic", foreign_keys="Author.section4_id")
    author_sec5 = relationship(
        "Author", backref="sec5", lazy="dynamic", foreign_keys="Author.section5_id")


class Author(Base):
    __tablename__ = "authors"

    id = Column(Integer, primary_key=True, index=True)
    emoji = Column(String(length=50), default="")
    avatar = Column(String(100), default="")

    name_en = Column(String(length=100), default="")
    quotesof_en = Column(String(length=100), default="")
    description_en = Column(Text(), default="")

    name_ru = Column(String(length=100), default="")
    quotesof_ru = Column(String(length=100), default="")
    description_ru = Column(Text(), default="")

    section1_id = Column(Integer, ForeignKey("sections.id"))
    section2_id = Column(Integer, ForeignKey("sections.id"))
    section3_id = Column(Integer, ForeignKey("sections.id"))
    section4_id = Column(Integer, ForeignKey("sections.id"))
    section5_id = Column(Integer, ForeignKey("sections.id"))

    quotes = relationship("Quote", back_populates="authors")


class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    emoji = Column(String(length=50), default="")
    avatar = Column(String(100), default="")

    name_en = Column(String(length=100), default="")
    about_en = Column(String(length=100), default="")
    description_en = Column(Text(), default="")

    name_ru = Column(String(length=100), default="")
    about_ru = Column(String(length=100), default="")
    description_ru = Column(Text(), default="")

    quote_cat1 = relationship("Quote", backref="cat1", lazy="dynamic", foreign_keys="Quote.category1_id")
    quote_cat2 = relationship("Quote", backref="cat2", lazy="dynamic", foreign_keys="Quote.category2_id")
    quote_cat3 = relationship("Quote", backref="cat3", lazy="dynamic", foreign_keys="Quote.category3_id")
    quote_cat4 = relationship("Quote", backref="cat4", lazy="dynamic", foreign_keys="Quote.category4_id")
    quote_cat5 = relationship("Quote", backref="cat5", lazy="dynamic", foreign_keys="Quote.category5_id")

class Quote(Base):
    __tablename__ = "quotes"

    id = Column(Integer, primary_key=True, index=True)
    rating = Column(Integer, default=0)
    content = Column(Text, default="")

    author_id = Column(Integer, ForeignKey("authors.id"))
    language_id = Column(Integer, ForeignKey("languages.id"))

    category1_id = Column(Integer, ForeignKey("categories.id"))
    category2_id = Column(Integer, ForeignKey("categories.id"))
    category3_id = Column(Integer, ForeignKey("categories.id"))
    category4_id = Column(Integer, ForeignKey("categories.id"))
    category5_id = Column(Integer, ForeignKey("categories.id"))

    authors = relationship("Author", back_populates="quotes")
    languages = relationship("Language", back_populates="quotes")


class Background(Base):
    __tablename__ = "backgrounds"

    id = Column(Integer, primary_key=True, index=True)
    name_en = Column(String(length=100), default="")
    name_ru = Column(String(length=100), default="")
    search = Column(String(length=100), default="")
    folder = Column(String(length=100), default="")
    count = Column(Integer, default=0)
