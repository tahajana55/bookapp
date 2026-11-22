import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/theme.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    loadUser();
  }
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final username =
    await secureStorage.read(key: "username");

    setState(() {
      nameController.text =
          prefs.getString("name") ?? "";

      emailController.text =
          prefs.getString("email") ?? "";

      usernameController.text =
          username ?? "";
    });
  }

  Future<void> saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "name",
      nameController.text,
    );

    await prefs.setString(
      "email",
      emailController.text,

    );

    await secureStorage.write(
      key: "username",
      value: usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  await saveUser();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                      Text("Profile Saved"),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  foregroundColor:
                  Colors.white,
                ),
                child: const Text(
                  "Save",

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}