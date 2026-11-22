import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/theme.dart';
import '../../database/database_helper.dart';

class EditBookScreen extends StatefulWidget {
  final Map<String, dynamic> book;


  const EditBookScreen({
    super.key,
    required this.book,
  });

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController reviewController;
  double rating = 0;


  @override
  void initState() {
    super.initState();
    reviewController = TextEditingController(
      text: widget.book["review"],
    );
    rating = widget.book["rating"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Book",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Update Rating",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 15),

            RatingBar.builder(
              initialRating: rating,
              minRating: 0,
              itemCount: 5,
              itemSize: 40,
              allowHalfRating: true,
              itemBuilder: (context, index){
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },


              onRatingUpdate: (value){
                setState(() {
                  rating = value;
                });
              },
            ),


            const SizedBox(height: 30),

            TextField(
              controller: reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Review",
                hintText: "Write your review",

              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.updateBook(
                      widget.book["id"],
                      {
                        "rating": rating,
                        "review": reviewController.text,
                      },
                  );
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Save Changes",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}