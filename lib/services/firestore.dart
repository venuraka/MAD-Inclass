import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/degreesmodel.dart';

class FirestoreService {
  final CollectionReference degreeCollection =
  FirebaseFirestore.instance.collection('degrees');

  Future<void> addDegree(String name, String duration) async {
    await degreeCollection.add({'name': name, 'duration': duration});
  }

  Stream<List<Degree>> getDegrees() {
    return degreeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Degree.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> updateDegree(String id, String name, String duration) async {
    await degreeCollection.doc(id).update({'name': name, 'duration': duration});
  }

  Future<void> deleteDegree(String id) async {
    await degreeCollection.doc(id).delete();
  }
}