// import 'package:cloud_firestore/cloud_firestore.dart';

// class TransactionModel {
//   final String id;
//   final double amount;
//   final String type;
//   final String description;
//   final DateTime timestamp;

//   TransactionModel({
//     required this.id,
//     required this.amount,
//     required this.type,
//     required this.description,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'amount': amount,
//       'type': type,
//       'description': description,
//       'timestamp': Timestamp.fromDate(timestamp),
//     };
//   }

//   factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
//     Timestamp timestamp;
    
//     if (map['timestamp'] is Timestamp) {
//       timestamp = map['timestamp'] as Timestamp;
//     } else if (map['timestamp'] is DateTime) {
//       timestamp = Timestamp.fromDate(map['timestamp'] as DateTime);
//     } else {
//       timestamp = Timestamp.now();
//     }
    
//     return TransactionModel(
//       id: id,
//       amount: (map['amount'] ?? 0).toDouble(),
//       type: map['type'] ?? 'credit',
//       description: map['description'] ?? '',
//       timestamp: timestamp.toDate(),
//     );
//   }
// }