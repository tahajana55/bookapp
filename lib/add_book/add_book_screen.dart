import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/theme.dart';
import '../../database/database_helper.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final reviewController = TextEditingController();
  final imageController = TextEditingController();

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Book")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,

              decoration: BoxDecoration(
                // color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Icon(
                Icons.add_photo_alternate_outlined,
                size: 70,
                // color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: " Enter Book Title",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: "Author",
                hintText: "Enter Author Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: " Write a short description...",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Image URL",
                hintText: "Paste image link",
              ),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rating",
                style: TextStyle(
                  fontSize: 18,
                  // color: AppColors.text,
                ),
              ),
            ),

            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              itemCount: 5,
              itemSize: 35,

              allowHalfRating: true,
              itemBuilder: (context, index) {
                return const Icon(Icons.star, color: Colors.amber);
              },
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Review (optional)",
                hintText: " Add your review (optional)",
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.insertBook({
                    "title": titleController.text,
                    "author": authorController.text,
                    "description": descriptionController.text,
                    "image": imageController.text,
                    "review": reviewController.text,
                    "rating": rating,
                  });
                },
                child: const Text("Save Book", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
