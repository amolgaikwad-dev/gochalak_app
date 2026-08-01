  import 'package:flutter/material.dart';
  import 'document_viewer_screen.dart';
  import 'package:gochalak_driver/services/api_service.dart';


class DocumentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onView;

  const DocumentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onView,
  });






  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE0F2F1),
          child: Icon(
            icon,
            color: const Color(0xFF00897B),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Verified by Admin"),
        trailing: TextButton(
          onPressed: onView,
          child: const Text(
            "View",
            style: TextStyle(
              color: Color(0xFF00897B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}








  class DocumentsScreen extends StatefulWidget {
    const DocumentsScreen({super.key});

    @override
    State<DocumentsScreen> createState() => _DocumentsScreenState();
  }

  class _DocumentsScreenState extends State<DocumentsScreen> {
    Map<String, dynamic>? documents;


    @override
    void initState() {
      super.initState();

      loadDocuments();
    }

    Future<void> loadDocuments() async {
      final data = await ApiService.driverDocuments();

      setState(() {
        documents = data;
      });

      print(documents);
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documents"),
        centerTitle: true,
      ),


      //body started
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Driver Documents",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),




            const SizedBox(height: 8),

            const Text(
              "View your verified documents.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 25),



            //driving licence CARD

            DocumentCard(
              icon: Icons.badge,
              title: "Driving Licence",
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(
                      imageUrl: documents?["driving_licence"] ?? "",
                    ),
                  ),
                );
              },
            ),



            //adhar FRONT

            DocumentCard(
              icon: Icons.credit_card,
              title: "Aadhaar Front",
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(
                      imageUrl: documents?["aadhaar_front"] ?? "",
                    ),
                  ),
                );
              },
            ),





            // adhar BACK

            DocumentCard(
              icon: Icons.credit_card,
              title: "Aadhaar Back",
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(
                      imageUrl: documents?["aadhaar_back"] ?? "",
                    ),
                  ),
                );
              },
            ),





            DocumentCard(
              icon: Icons.credit_card,
              title: "Pan Card",
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(
                      imageUrl: documents?["pan_card"] ?? "",
                    ),
                  ),
                );
              },
            ),




            DocumentCard(
              icon: Icons.credit_card,
              title: "Police Verification",
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(
                      imageUrl: documents?["police_verification"] ?? "",
                    ),
                  ),
                );
              },
            ),























          ],
        ),
      ),
    );
  }
}

