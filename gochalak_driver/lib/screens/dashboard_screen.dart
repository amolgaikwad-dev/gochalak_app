import 'package:flutter/material.dart';
import 'package:gochalak_driver/services/api_service.dart';
import 'package:gochalak_driver/screens/profile_screen.dart';
import 'package:gochalak_driver/screens/documents_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? driverId;
  String? fullName;
  String? profilePhoto;
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "👋 Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "☀️ Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "🌆 Good Evening";
    } else {
      return "🌙 Good Night";
    }
  }
  bool isOnDuty = false;
  //bool isOffDuty = true;


  @override
  void initState() {

    super.initState();
    loadProfile();

  }
  Future<void> loadProfile() async {
    final data = await ApiService.driverProfile();

    print(data);

    setState(() {
      driverId = data["driver_id"];
      fullName = data["full_name"];
      profilePhoto = data["profile_photo"];
    });

    print(fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------------------------------------------------------
      // Navigation Drawer (Hamburger Menu)
      // ---------------------------------------------------------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [

            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              color: const Color(0xFF00897B),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "${ApiService.baseUrl}$profilePhoto",
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Welcome GOChalak",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Driver ID: ${driverId ?? ''}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    fullName ?? "Loading...",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),



            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.description),
              title: Text("Documents"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DocumentsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.wallet),
              title: Text("Wallet"),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text("accounts"),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("settings"),
              onTap: () {},
            ),
          ],
        ),
      ),



      //  ---------------------------------------------------------
      // App Bar
      // ---------------------------------------------------------
      appBar: AppBar(
        title: const Text("GOChalak Driver"),
        centerTitle: true,
      ),

      // ---------------------------------------------------------
      // Empty Dashboard Body
      // ---------------------------------------------------------
      body: Container(
        color: const Color(0xFFF4F8F7),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                getGreeting(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                fullName ?? "Loading...",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Have a safe and great day! 🚖",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Duty Status",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

          GestureDetector(
            onTap: () {
              setState(() {
                isOnDuty = !isOnDuty;
              });
            },

            //card started
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isOnDuty
                      ? const Color(0xFF00897B)
                      : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 35,
                    horizontal: 20,
                  ),


                  //column started

                  child: Column(
                    children: [

                      Icon(
                        Icons.power_settings_new,
                        size: 90,
                        color: isOnDuty
                            ? Colors.white
                            : Colors.grey,
                      ),

                      SizedBox(height: 20),

                      Text(
                        isOnDuty ? "ON DUTY" : "OFF DUTY",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),



                      Text(
                        isOnDuty
                            ? "You are receiving trip requests"
                            : "Tap to start receiving trip requests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),


                    ],
                    //column end

                  ),
                ),
              ),



          ),

              //todays summry started
              const SizedBox(height: 30),

              const Text(
                "Today's Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),



              //card 1 trips CARD

              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.local_taxi,
                              size: 35,
                              color: const Color(0xFF00897B),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00897B),
                              ),
                            ),
                            Text("Trips"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),


                //card 2 earnings CARD
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.currency_rupee,
                              size: 35,
                              color: const Color(0xFF00897B),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "₹0",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00897B),
                              ),
                            ),
                            Text("Earnings"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),






    );
  }
}