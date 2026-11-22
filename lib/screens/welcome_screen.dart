import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 90),

              Image.network(
                "https://thumbs.dreamstime.com/b/there-pink-books-adorned-beautiful-flowers-white-background-lovely-stack-placed-clean-creating-vibrant-contrast-331043774.jpg",
                height: 260,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrack) {
                  return const Icon(
                    Icons.menu_book,
                    size: 120,
                    color: Colors.pink,
                  );
                },
              ),

              const SizedBox(height: 40),

              const Text(
                "Welcome to",
                style: TextStyle(fontSize: 28, color: AppColors.text),
              ),

              const SizedBox(height: 0),

              const Text(
                "Book Nook",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Track your favorite books,\n"
                "Read • Rate • Review",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: const Text(
                    "Get Started   >",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
