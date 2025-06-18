import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/firestore.dart';
import '../models/degreesmodel.dart';
import 'addeditscreen.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
              'Degree Management',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.greenAccent,
      ),  body: StreamBuilder<List<Degree>>(
        stream: firestoreService.getDegrees(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var degrees = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: degrees.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(degrees[index].name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  subtitle: Text("Duration: ${degrees[index].duration} years", style: GoogleFonts.poppins()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CRUDScreen(degree: degrees[index])),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => firestoreService.deleteDegree(degrees[index].id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CRUDScreen())),
      ),
    );
  }
}