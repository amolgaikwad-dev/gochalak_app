// Library used to convert Dart objects to JSON
// and JSON responses back into Dart objects.
import 'dart:convert';

// HTTP package used to communicate with the Django backend.
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
// ---------------------------------------------------------
// API Service
// ---------------------------------------------------------
// This class contains all methods responsible for
// communicating with the backend server.
//
// Instead of writing HTTP requests in every screen,
// all API-related logic is kept here.
// ---------------------------------------------------------
class ApiService {

  // Base URL of the Django backend.
  // All API endpoints are built using this URL.
  //
  // Example:
  // Login API ->
  // http://127.0.0.1:8000/api/accounts/login/
  static const String baseUrl = "http://10.0.2.2:8000";

  // ---------------------------------------------------------
  // Login API
  // ---------------------------------------------------------
  // Sends the driver's mobile number and password
  // to the Django backend for authentication.
  //
  // Returns:
  // - Access Token
  // - Refresh Token
  // - Success or Error response
  // ---------------------------------------------------------
  static Future<Map<String, dynamic>> login({

    // Driver's registered mobile number.
    required String mobile,

    // Driver's login password.
    required String password,

  }) async {

    // Send an HTTP POST request to the Login API.
    final response = await http.post(

      // Complete API endpoint.
      Uri.parse("$baseUrl/api/accounts/login/"),

      // Inform the server that JSON data
      // is being sent in the request body.
      headers: {
        "Content-Type": "application/json",
      },

      // Convert the Dart Map into JSON format
      // before sending it to the backend.
      body: jsonEncode({
        "mobile": mobile,
        "password": password,
      }),
    );

    // Convert the JSON response received from
    // the Django backend into a Dart Map
    // so it can be used inside the Flutter app.
    return jsonDecode(response.body);
  }

  //driver profile
  static Future<Map<String, dynamic>> driverProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    final response = await http.get(
      Uri.parse("$baseUrl/api/drivers/profile/"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print(response.body);
    return jsonDecode(response.body);
  }


  //driver documents
  static Future<Map<String, dynamic>> driverDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.get(
      Uri.parse("$baseUrl/api/drivers/documents/"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print(response.body);
    return jsonDecode(response.body);
  }
}

