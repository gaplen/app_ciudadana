// import 'package:cloud_firestore/cloud_firestore.dart';

// class Event {
//   final String title;
//   final DateTime dateTime;
//   final String? description;
//   final DateTime date;
//   final String id;
//   Event({
//     required this.title,
//     required this.dateTime,
//     this.description,
//     required this.date,
//     required this.id,
//   });

//   factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
//       [SnapshotOptions? options]) {
//     final data = snapshot.data()!;
//     return Event(
//       date: data['date'].toDate(),
//       dateTime: data['hora'].toString() != null
//           ? data['hora'].toDate()
//           : DateTime.now(),
//       title: data['title'],
//       description: data['description'],
//       id: snapshot.id,
//     );
//   }

//   Map<String, Object?> toFirestore() {
//     return {
//       "date": Timestamp.fromDate(date),
//       "hora": Timestamp.fromDate(dateTime),
//       "title": title,
//       "description": description
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final DateTime dateTime;
  final String? description;
  final DateTime date;
  final String id;

  Event({
    required this.title,
    required this.dateTime,
    this.description,
    required this.date,
    required this.id,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      date: data['date'].toDate(),
      dateTime: data['hora'] != null ? data['hora'].toDate() : DateTime.now(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "hora": Timestamp.fromDate(dateTime),
      "title": title,
      "description": description,
    };
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';

// class Event {
//   final String title;
//   // final DateTime dateTime;
//   final String? description;
//   final DateTime date;
//   final String id;

//   Event({
//     required this.title,
//     // required this.dateTime,
//     this.description,
//     required this.date,
//     required this.id,
//   });

//   factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
//       [SnapshotOptions? options]) {
//     final data = snapshot.data()!;
//     return Event(
//       date: data['date'].toDate(),
//       // dateTime: data['hora'] != null ? data['hora'].toDate() : DateTime.now(),
//       title: data['title'],
//       description: data['description'],
//       id: snapshot.id,
//     );
//   }

//   Map<String, Object?> toFirestore() {
//     return {
//       "date": Timestamp.fromDate(date),
//       // "hora": Timestamp.fromDate(dateTime),
//       "title": title,
//       "description": description
//     };
//   }
// }
