import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/firestore.dart';
import '../models/degreesmodel.dart';

class CRUDScreen extends StatefulWidget {
  final Degree? degree;

  CRUDScreen({this.degree});

  @override
  _CRUDScreenState createState() => _CRUDScreenState();
}

class _CRUDScreenState extends State<CRUDScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _duration;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _name = widget.degree?.name;
    _duration = widget.degree?.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.degree == null ? 'Add Degree' : 'Edit Degree', style: GoogleFonts.poppins()),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Degree', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                validator: (value) => value!.isEmpty ? 'Enter Degree Name' : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _duration,
                decoration: InputDecoration(labelText: 'Duration (years)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter duration' : null,
                onSaved: (value) => _duration = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(widget.degree == null ? 'Add' : 'Update', style: GoogleFonts.poppins(fontSize: 16)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.degree == null) {
                      await firestoreService.addDegree(_name!, _duration!);
                    } else {
                      await firestoreService.updateDegree(widget.degree!.id, _name!, _duration!);
                    }
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}