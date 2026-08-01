// Import Flutter's Material Design library.
import 'package:flutter/material.dart';

// Import the Login Screen.
// This is the first screen displayed when the app starts.
import 'screens/login_screen.dart';


// ---------------------------------------------------------
// Application Entry Point
// ---------------------------------------------------------
// The main() function is the starting point of every
// Flutter application.
//
// Execution starts from here.
// ---------------------------------------------------------
void main() {

  // Launch the Flutter application.
  runApp(const GOChalakDriverApp());
}


// ---------------------------------------------------------
// Root Widget of the Application
// ---------------------------------------------------------
// This widget initializes the application and defines
// global settings such as:
//
// • App title
// • Theme
// • Initial screen
// • Navigation
// ---------------------------------------------------------
class GOChalakDriverApp extends StatelessWidget {
  const GOChalakDriverApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Configure the main Material Design application.
    return MaterialApp(

      // Remove the DEBUG banner displayed
      // in the top-right corner during development.
      debugShowCheckedModeBanner: false,

      // Application title.
      title: 'GOChalak Driver',

      // Initial screen displayed when the application starts.
      //
      // Later this can be replaced with a SplashScreen
      // that checks whether the driver is already logged in.
      home: const LoginScreen(),
    );
  }
}