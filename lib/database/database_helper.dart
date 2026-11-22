import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static Database? database;

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    database = await openDatabase(
      join(
        await getDatabasesPath(),
        dotenv.env["DATABASE_NAME"] ?? "books.db",
      ),

      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          author TEXT,
          description TEXT,
          image TEXT,
          review TEXT,
          rating REAL
          )
        ''');
      },
    );

    return database!;
  }
  static Future<void> insertBook(
      Map<String, dynamic> book,
      ) async {

    final db = await getDatabase();
    await db.insert(
      "books",
      book,
    );
  }

  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await getDatabase();
    return await db.query("books");
  }

  static Future<void> updateBook(
      int id,
      Map<String, dynamic> book,
      ) async {
    final db = await getDatabase();
    await db.update(
      "books",
      book,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> insertDefaultBooks() async {
    final db = await getDatabase();
    final count = Sqflite.firstIntValue(

      await db.rawQuery(
          "SELECT COUNT(*) FROM books"
      ),
    );

    if (count == 0) {
      await db.insert(
        "books",
        {
          "title": "Atomic Habits",
          "author": "James Clear",
          "description":
          "A book about building good habits and breaking bad ones.",
          "image":
          "https://m.media-amazon.com/images/I/91bYsX41DVL.jpg",
          "review":
          "Very useful book",
          "rating": 4.8,
        },
      );

      await db.insert(
        "books",
        {
          "title": "The Alchemist",
          "author": "Paulo Coelho",
          "description":
          "A story about dreams and following your heart.",
          "image":
          "https://m.media-amazon.com/images/I/71aFt4+OTOL.jpg",
          "review":
          "Amazing story",
          "rating": 5.0,
        },
      );

      await db.insert(
        "books",
        {
          "title": "Rich Dad Poor Dad",
          "author": "Robert Kiyosaki",
          "description":
          "A book about money and finance.",
          "image":
          "https://m.media-amazon.com/images/I/81bsw6fnUiL.jpg",
          "review":
          "Helpful book",
          "rating": 4.5,
        },
      );
    }
  }
}