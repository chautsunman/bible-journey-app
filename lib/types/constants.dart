import 'package:bible_journey_app/types/general.dart';
import 'package:json_annotation/json_annotation.dart';

class Book extends ValidObj {
  final String name;
  final int numChapters;
  final String bibleAppShortName;

  Book(this.name, this.numChapters, this.bibleAppShortName);

  @override
  isValid() {
    return name != 'invalid_book';
  }

  static final Book GENESIS = Book('Genesis', 50, 'GEN');
  static final Book EXODUS = Book('Exodus', 40, 'EXO');
  static final Book LEVITICUS = Book('Leviticus', 27, 'LEV');
  static final Book NUMBERS = Book('Numbers', 36, 'NUM');
  static final Book DEUTERONOMY = Book('Deuteronomy', 34, 'DEU');
  static final Book JOSHUA = Book('Joshua', 24, 'JOS');
  static final Book JUDGES = Book('Judges', 21, 'JDG');
  static final Book RUTH = Book('Ruth', 4, 'RUT');
  static final Book SAMUEL1 = Book('1 Samuel', 31, '1SA');
  static final Book SAMUEL2 = Book('2 Samuel', 24, '2SA');
  static final Book KINGS1 = Book('1 Kings', 22, '1KI');
  static final Book KINGS2 = Book('2 Kings', 25, '2KI');
  static final Book CHRONICLES1 = Book('1 Chronicles', 29, '1CH');
  static final Book CHRONICLES2 = Book('2 Chronicles', 36, '2CH');
  static final Book EZRA = Book('Ezra', 10, 'EZR');
  static final Book NEHEMIAH = Book('Nehemiah', 13, 'NEH');
  static final Book ESTHER = Book('Esther', 10, 'EST');
  static final Book JOB = Book('Job', 42, 'JOB');
  static final Book PSALMS = Book('Psalms', 150, 'PSA');
  static final Book PROVERBS = Book('Proverbs', 31, 'PRO');
  static final Book ECCLESIASTES = Book('Ecclesiastes', 12, 'ECC');
  static final Book SONGOFSONGS = Book('Song of Songs', 8, 'SNG');
  static final Book ISIAH = Book('Isiah', 66, 'ISA');
  static final Book JEREMIAH = Book('Jeremiah', 52, 'JER');
  static final Book LAMENTATIONS = Book('Lamentations', 5, 'LAM');
  static final Book EZEKIEL = Book('Ezekiel', 48, 'EZK');
  static final Book DANIEL = Book('Daniel', 12, 'DAN');
  static final Book HOSEA = Book('Hosea', 14, 'HOS');
  static final Book JOEL = Book('Joel', 3, ' JOL');
  static final Book AMOS = Book('Amos', 9, 'AMO');
  static final Book OBADIAH = Book('Obadiah', 1, 'OBA');
  static final Book JONAH = Book('Jonah', 4, 'JON');
  static final Book MICAH = Book('Micah', 7, 'MIC');
  static final Book NAHUM = Book('Nahum', 3, 'NAM');
  static final Book HABAKKUK = Book('Habakkuk', 3, 'HAB');
  static final Book ZEPHANIAH = Book('Zephaniah', 3, 'ZEP');
  static final Book HAGGAI = Book('Haggai', 2, 'HAG');
  static final Book ZECHARIAH = Book('Zechariah', 14, 'ZEC');
  static final Book MALACHI = Book('Malachi', 4, 'MAL');
  static final Book MATTHEW = Book('Matthew', 28, 'MAT');
  static final Book MARK = Book('Mark', 16, 'MRK');
  static final Book LUKE = Book('Luke', 24, 'LUK');
  static final Book JOHN = Book('John', 21, 'JHN');
  static final Book ACTS = Book('Acts', 28, 'ACT');
  static final Book ROMANS = Book('Romans', 16, 'ROM');
  static final Book CORINTHIANS1 = Book('1 Corinthians', 16, '1CO');
  static final Book CORINTHIANS2 = Book('2 Corinthians', 13, '2CO');
  static final Book GALATIANS = Book('Galatians', 6, 'GAL');
  static final Book EPHESIANS = Book('Ephesians', 6, 'EPH');
  static final Book PHILLIPIANS = Book('Phillipians', 4, 'PHP');
  static final Book COLOSSIANS = Book('Colossians', 4, 'COL');
  static final Book THESSALONIANS1 = Book('1 Thessalonians', 5, '1TH');
  static final Book THESSALONIANS2 = Book('2 Thessalonians', 3, '2TH');
  static final Book TIMOTHY1 = Book('1 Timothy', 6, '1TI');
  static final Book TIMOTHY2 = Book('2 Timothy', 4, '2TI');
  static final Book TITUS = Book('Titus', 3, 'TIT');
  static final Book PHILEMON = Book('Philemon', 1, 'PHM');
  static final Book HEBREWS = Book('Hebrews', 13, 'HEB');
  static final Book JAMES = Book('James', 5, 'JAS');
  static final Book PETER1 = Book('1 Peter', 5, '1PE');
  static final Book PETER2 = Book('2 Peter', 3, '2PE');
  static final Book JOHN1 = Book('1 John', 5, '1JN');
  static final Book JOHN2 = Book('2 John', 1, '2JN');
  static final Book JOHN3 = Book('3 John', 1, '3JN');
  static final Book JUDE = Book('Jude', 1, 'JUD');
  static final Book REVELATION = Book('Revelation', 22, 'REV');
  static final Book _INVALID_BOOK = Book('invalid_book', -1, 'invalid_book');

  static String bookToJson(Book book) {
    return book.name;
  }
  static Book bookFromJson(String jsonStr) {
    return getBookFromName(jsonStr);
  }
}

final List<Book> BOOKS = [
  Book.GENESIS,
  Book.EXODUS,
  Book.LEVITICUS,
  Book.NUMBERS,
  Book.DEUTERONOMY,
  Book.JOSHUA,
  Book.JUDGES,
  Book.RUTH,
  Book.SAMUEL1,
  Book.SAMUEL2,
  Book.KINGS1,
  Book.KINGS2,
  Book.CHRONICLES1,
  Book.CHRONICLES2,
  Book.EZRA,
  Book.NEHEMIAH,
  Book.ESTHER,
  Book.JOB,
  Book.PSALMS,
  Book.PROVERBS,
  Book.ECCLESIASTES,
  Book.SONGOFSONGS,
  Book.ISIAH,
  Book.JEREMIAH,
  Book.LAMENTATIONS,
  Book.EZEKIEL,
  Book.DANIEL,
  Book.HOSEA,
  Book.JOEL,
  Book.AMOS,
  Book.OBADIAH,
  Book.JONAH,
  Book.MICAH,
  Book.NAHUM,
  Book.HABAKKUK,
  Book.ZEPHANIAH,
  Book.HAGGAI,
  Book.ZECHARIAH,
  Book.MALACHI,
  Book.MATTHEW,
  Book.MARK,
  Book.LUKE,
  Book.JOHN,
  Book.ACTS,
  Book.ROMANS,
  Book.CORINTHIANS1,
  Book.CORINTHIANS2,
  Book.GALATIANS,
  Book.EPHESIANS,
  Book.PHILLIPIANS,
  Book.COLOSSIANS,
  Book.THESSALONIANS1,
  Book.THESSALONIANS2,
  Book.TIMOTHY1,
  Book.TIMOTHY2,
  Book.TITUS,
  Book.PHILEMON,
  Book.HEBREWS,
  Book.JAMES,
  Book.PETER1,
  Book.PETER2,
  Book.JOHN1,
  Book.JOHN2,
  Book.JOHN3,
  Book.JUDE,
  Book.REVELATION
];

var BOOK_NAMES = BOOKS.map((e) => e.name).toList();

var BOOKS_SET = BOOKS.toSet();

Book getBookFromName(String name) {
  for (var i = 0; i < BOOKS.length; i++) {
    if (name == BOOKS[i].name) {
      return BOOKS[i];
    }
  }
  return Book._INVALID_BOOK;
}

class BookChapter extends ValidObj {
  Book book;
  int chapter;

  BookChapter(this.book, this.chapter);

  @override
  String toString() {
    return '${book.name} - $chapter';
  }

  @override
  bool isValid() {
    return this != BookChapter.INVALID_BOOK_CHAPTER && BOOKS_SET.contains(book) && chapter > 0 && chapter <= book.numChapters;
  }

  String getBibleAppLink() {
    return 'https://bible.com/bible/139/${book.bibleAppShortName}.$chapter.RCUV';
  }

  static BookChapter fromString(String bookChapterStr) {
    var split = bookChapterStr.split(' - ');
    if (split.length != 2) {
      return INVALID_BOOK_CHAPTER;
    }
    var book = getBookFromName(split[0]);
    if (book == null) {
      return INVALID_BOOK_CHAPTER;
    }
    var chapter = -1;
    try {
      chapter = int.parse(split[1]);
    } catch (e) {

    }
    if (chapter == -1) {
      return INVALID_BOOK_CHAPTER;
    }
    var bookChapter = BookChapter(book, chapter);
    if (!bookChapter.isValid()) {
      return INVALID_BOOK_CHAPTER;
    }
    return bookChapter;
  }

  static BookChapter INVALID_BOOK_CHAPTER = BookChapter(Book.GENESIS, -1);
}

class BookChapterJsonConvertor implements JsonConverter<BookChapter, String> {
  const BookChapterJsonConvertor();

  @override
  BookChapter fromJson(String json) {
    return BookChapter.fromString(json);
  }

  @override
  String toJson(BookChapter object) {
    return object.toString();
  }
}
