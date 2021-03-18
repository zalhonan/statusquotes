from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Table, Text
from sqlalchemy.orm import sessionmaker, scoped_session, relationship

from .database import Base


class Quote(Base):
    __tablename__ = "quotes"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))
    content = Column(Text, unique=True)
    category_id = Column(Integer, ForeignKey("categories.id"))
    author_id = Column(Integer, ForeignKey("authors.id"))

    rating_plus = Column(Integer, default=0)
    rating_minus = Column(Integer, default=0)

    tags = relationship("Tag", secondary="quote_tag", back_populates="quotes")

    # authors = relationship("Author", back_populates="quotes")
    # languages = relationship("Language", back_populates="quotes")
    # categories = relationship("Category", back_populates="quotes")
    # tags = relationship("Tag", back_populates="quotes")

    def __repr__(self):
        return f"content {self.content}"


class Tag(Base):
    __tablename__ = "tags"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))

    name = Column(String(length=200), default="", unique=True)
    about = Column(String(length=200), default="")

    emoji = Column(String(length=50), default="")
    avatar = Column(String(200), default="")

    description_id = Column(Integer, ForeignKey("descriptions.id"))

    quotes = relationship("Quote", secondary="quote_tag",
                          back_populates="tags")

    def __repr__(self):
        return f"name {self.name}, about: {self.about}"

    # languages = relationship("Language", back_populates="tags")
    # descriptions = relationship("Description", back_populates="tags")


class QuoteTag(Base):
    __tablename__ = "quote_tag"

    id = id = Column(Integer, primary_key=True, index=True)
    quote_id = Column(Integer, ForeignKey("quotes.id"))
    tag_id = Column(Integer, ForeignKey("tags.id"))

    def __repr__(self):
        return f"quote_id {self.quote_id}, tga_id: {self.tag_id}"


class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))

    name = Column(String(length=200), default="", unique=True)
    about = Column(String(length=200), default="")
    emoji = Column(String(length=50), default="")

    description_id = Column(Integer, ForeignKey("descriptions.id"))


class Language(Base):
    __tablename__ = "languages"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(length=50), unique=True, index=True)
    name = Column(String(length=50), unique=True, index=True)
    emoji = Column(String(length=50), default="")

    def __repr__(self):
        return f"code {self.code}, name: {self.name}, emoji: {self.emoji}"

    # quotes = relationship("Quote", back_populates="languages")


class Author(Base):
    __tablename__ = "authors"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))
    emoji = Column(String(length=50), default="")
    avatar = Column(String(200), default="")
    name = Column(String(length=200), default="", unique=True)
    about = Column(String(length=200), default="")
    description_id = Column(Integer, ForeignKey("descriptions.id"))

    def __repr__(self):
        return f"authors: id: {self.id}, name: {self.name} \n"


class Section(Base):
    __tablename__ = "sections"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))
    emoji = Column(String(length=50), default="")
    avatar = Column(String(200), default="")
    name = Column(String(length=200), default="", unique=True)
    about = Column(String(length=200), default="")
    description_id = Column(Integer, ForeignKey("descriptions.id"))


class AuthorSection(Base):
    __tablename__ = "author_section"

    id = id = Column(Integer, primary_key=True, index=True)
    author_id = Column(Integer, ForeignKey("authors.id"))
    section_id = Column(Integer, ForeignKey("sections.id"))


class Source(Base):
    __tablename__ = "sources"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))
    category_id = Column(Integer, ForeignKey("categories.id"))
    emoji = Column(String(length=50), default="")
    avatar = Column(String(200), default="")
    name = Column(String(length=200), default="", unique=True)
    about = Column(String(length=200), default="")
    description_id = Column(Integer, ForeignKey("descriptions.id"))


class QuoteSource(Base):
    __tablename__ = "quote_source"

    id = id = Column(Integer, primary_key=True, index=True)
    quote_id = Column(Integer, ForeignKey("quotes.id"))
    source_id = Column(Integer, ForeignKey("sources.id"))


class Background(Base):
    __tablename__ = "backgrounds"

    id = Column(Integer, primary_key=True, index=True)
    language_id = Column(Integer, ForeignKey("languages.id"))
    name = Column(String(length=200), default="")
    search = Column(String(length=200), default="")
    folder = Column(String(length=200), default="")
    count = Column(Integer, default=0)


class Description(Base):
    __tablename__ = "descriptions"

    id = Column(Integer, primary_key=True, index=True)
    content = Column(Text, unique=True)
