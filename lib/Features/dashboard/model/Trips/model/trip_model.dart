import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TripModel {
  final String id;
  final String from;
  final String to;
  final String driverName;
  final String carNumber;
  final DateTime startTime;
  final DateTime endTime;
  final num price;
  final int seats;
  final double rating;
  final String category;
  final String carType;  
  final int? availableSeats;

  TripModel({
    required this.id,
    required this.from,
    required this.to,
    required this.driverName,
    required this.carNumber,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.seats,
    this.rating = 4.5,
    this.category = "سيارة",
    this.carType = "عادية", 
    this.availableSeats = 0,
  });

  
  String get startTimeFormatted =>
      DateFormat('hh:mm a', 'en_US').format(startTime);

  String get endTimeFormatted =>
      DateFormat('hh:mm a', 'en_US').format(endTime);

  factory TripModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TripModel(
      id: doc.id,
      from: data['fromLocation']?['name'] ?? '',
      to: data['toLocation']?['name'] ?? '',
      driverName: data['driverName'] ?? '',
      carNumber: data['carNumber'] ?? '',
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      price: data['price'] ?? 0,
      seats: data['seats'] ?? 0,
      rating: (data['rating'] ?? 4.5).toDouble(),
      category: data['category'] ?? "سيارة",
      carType: data['carType'] ?? "عادية", 
      availableSeats: (data['availableSeats'] ?? data['seats'] ?? 0) is int
          ? (data['availableSeats'] ?? data['seats'] ?? 0)
          : int.tryParse("${data['availableSeats'] ?? data['seats']}") ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromLocation': {'name': from},
      'toLocation': {'name': to},
      'driverName': driverName,
      'carNumber': carNumber,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'price': price,
      'seats': seats,
      'rating': rating,
      'category': category,
      'carType': carType, 
      'availableSeats': availableSeats,
    };
  }
}
