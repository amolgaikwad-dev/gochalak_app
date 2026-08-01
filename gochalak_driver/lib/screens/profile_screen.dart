import 'package:flutter/material.dart';
import 'package:gochalak_driver/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? driverId;
  String? fullName;
  String? profilePhoto;
  String? mobile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await ApiService.driverProfile();

    setState(() {
      driverId = data["driver_id"];
      fullName = data["full_name"];
      mobile = data["mobile"];
      profilePhoto = data["profile_photo"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F7),
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: const Color(0xFF00897B),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: profilePhoto != null
                          ? NetworkImage(
                        "${ApiService.baseUrl}$profilePhoto",
                      )
                          : null,
                      child: profilePhoto == null
                          ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF00897B),
                      )
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      fullName ?? "Loading...",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Driver ID : ${driverId ?? ''}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color(0xFF00897B),
                    ),
                    title: const Text("Full Name"),
                    subtitle: Text(fullName ?? "Loading..."),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.badge,
                      color: Color(0xFF00897B),
                    ),
                    title: const Text("Driver ID"),
                    subtitle: Text("${driverId ?? ''}"),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Color(0xFF00897B),
                    ),
                    title: const Text("Mobile Number"),
                    subtitle: Text(mobile ?? "Loading..."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}