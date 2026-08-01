import 'package:flutter/material.dart';

class DocumentViewerScreen extends StatelessWidget {
  final String imageUrl;

  const DocumentViewerScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Documents"),
      ),
      body: Center(
        child: Image.network(
          "http://10.0.2.2:8000$imageUrl",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}



