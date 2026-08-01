// Flutter's core Material Design widgets.
import 'package:flutter/material.dart';

// Used to display SVG images inside the Flutter application.
import 'package:flutter_svg/flutter_svg.dart';

// Handles communication between Flutter and the Django backend.
import '../services/api_service.dart';

// Used to store data locally on the device
// (e.g., JWT Access Token and Refresh Token).
import 'package:shared_preferences/shared_preferences.dart';

// Import the Dashboard screen displayed after successful login.
import 'dashboard_screen.dart';


// Primary theme color used throughout the login screen.
const Color primaryColor = Color(0xFF00897B);


// ---------------------------------------------------------
// Login Screen
// ---------------------------------------------------------
// This screen allows drivers to authenticate using
// their mobile number and password.
// ---------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


// ---------------------------------------------------------
// Login Screen State
// ---------------------------------------------------------
// Manages user input, animations, login requests,
// and navigation after successful authentication.
// ---------------------------------------------------------
class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  // Controller for the mobile number input field.
  final TextEditingController mobileController = TextEditingController();

  // Controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  // Stores the animated GOChalak title.
  String animatedText = "";

  // Controls the title animation.
  late AnimationController animationController;

  // Controls the slide animation effect.
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller.
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Configure the title to slide from the top.
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Start the animation.
    animationController.forward();

    // Word displayed with the typing animation.
    const word = "GOChalak";

    // Animate the title by revealing one character at a time.
    Future.delayed(const Duration(milliseconds: 200), () async {
      for (int i = 0; i < word.length; i++) {

        // Prevent updates if the widget has already been removed.
        if (!mounted) return;

        setState(() {
          animatedText += word[i];
        });

        await Future.delayed(
          const Duration(milliseconds: 120),
        );
      }
    });
  }

  @override
  void dispose() {

    // Release animation resources.
    animationController.dispose();

    // Dispose text controllers to prevent memory leaks.
    mobileController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Build the complete Login Screen UI.
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 40),

                // Animated GOChalak title.
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),

                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },

                  child: Text(
                    animatedText,
                    key: ValueKey(animatedText),

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,

                      // Apply a gradient effect to the title.
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF1E293B),
                            Color(0xFF00897B),
                          ],
                        ).createShader(
                          const Rect.fromLTWH(0, 0, 300, 70),
                        ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Driver subtitle.
                const Text(
                  "Driver",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 40),

                // Mobile number input field.
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    hintText: "Enter Mobile Number",

                    prefixIcon: const Icon(
                      Icons.phone,
                      color: primaryColor,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Password input field.
                TextField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Password",

                    prefixIcon: const Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Login button.
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    onPressed: () async {

                      // Send login request to the Django backend.
                      final response = await ApiService.login(
                        mobile: mobileController.text,
                        password: passwordController.text,
                      );

                      // Login successful.
                      if (response["access"] != null) {

                        // Access local device storage.
                        final prefs =
                        await SharedPreferences.getInstance();

                        // Store JWT tokens for future authenticated requests.
                        await prefs.setString(
                          "access_token",
                          response["access"],
                        );

                        await prefs.setString(
                          "refresh_token",
                          response["refresh"],
                        );

                        print("Token Saved Successfully");

                        // Navigate to the Dashboard
                        // and remove the Login screen
                        // from the navigation stack.
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const DashboardScreen(),
                          ),
                        );

                      } else {

                        // Login failed.
                        print(response["message"]);
                      }
                    },

                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Driver illustration.
                Center(
                  child: SvgPicture.asset(
                    "assets/images/driver.svg",
                    width: 220,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                // Company branding.
                const Text(
                  "Powered by",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Shivnya Technologies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}