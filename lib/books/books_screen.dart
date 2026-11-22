import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../database/database_helper.dart';
import 'book_details_screen.dart';


class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});
  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Map<String, dynamic>> books = [];
  List<Map<String, dynamic>> filteredBooks = [];
  final searchController = TextEditingController();

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }


  void loadBooks() async {
    await DatabaseHelper.insertDefaultBooks();
    final data = await DatabaseHelper.getBooks();

    setState(() {
      books = data;
      filteredBooks = data;
    });
  }

  void searchBook(String value) {
    setState(() {
      filteredBooks = books.where((book) {
        return book["title"]
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase());

      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          onChanged: searchBook,
          decoration: const InputDecoration(
            hintText: "Search books...",
            border: InputBorder.none,
          ),
        )
            : const Text(
          "My Books",
        ),

        actions: [
          IconButton(
            icon: Icon(
              isSearching
                  ? Icons.close
                  : Icons.search,
            ),

            onPressed: () {
              setState(() {
                if(isSearching){
                  isSearching = false;
                  searchController.clear();
                  filteredBooks = books;
                }

                else{
                  isSearching = true;
                }
              });
            },
          ),
        ],
      ),

      body: filteredBooks.isEmpty

          ? const Center(
        child: Text(
          "No Books Added Yet",
        ),
      )

          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          final book = filteredBooks[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(
                    book: book,
                  ),
                ),
              );
            },

            child: Container(
              margin: const EdgeInsets.only(
                bottom: 15,
              ),

              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),


              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(15),
                    child: Image.network(
                      book["image"],
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),


                  const SizedBox(width: 20),

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        book["title"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),

                          Text(
                            book["rating"].toString(),
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 16,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}