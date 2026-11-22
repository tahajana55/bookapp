import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import 'edit_book_screen.dart';


class BookDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsScreen> createState() =>
      _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Map<String, dynamic> book;

  @override
  void initState() {
    super.initState();
    book = widget.book;
  }

  Future<void> refreshBook() async {
    final books = await DatabaseHelper.getBooks();

    final updatedBook = books.firstWhere(
          (item) => item["id"] == book["id"],
    );
    setState(() {
      book = updatedBook;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book["title"],
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),

            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookScreen(
                    book: book,
                  ),
                ),
              );
              refreshBook();
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Image.network(
                book["image"],
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),

            const SizedBox(height: 20),


            Text(
              book["title"],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Author: ${book["author"]}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),


            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),

                const SizedBox(width: 5),


                Text(
                  book["rating"].toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book["description"],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Review",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book["review"].toString().isEmpty
                  ? "No Review Yet"
                  : book["review"],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}