import 'package:cloud_firestore/cloud_firestore.dart';

class Houses {
  String? id;  // Firestore Document ID
  String address;
  int rooms;
  int squareFeet;
  DocumentReference? reference;

  Houses({this.id, required this.address, required this.rooms, required this.squareFeet, this.reference});

  // Convert Grade to Map
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'rooms': rooms,
      'squareFeet': squareFeet
    };
  }

  // Convert Map to Houses object
  factory Houses.fromMap(Map<String, dynamic> map, DocumentReference reference) {
    return Houses(
      id: reference.id,
      address: map['address'],
      rooms: map['rooms'],
      squareFeet: map['squareFeet'],
      reference: reference,
    );
  }
}
