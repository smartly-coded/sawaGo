import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TripModel {
  final String id;
  final String from;
  final String to;
  final String driverId;
  final String driverName;
  final DateTime startTime;
  final DateTime endTime;
  final num price;
  final int seats;
  final double rating;
  final String category;
  final String carType;
  final int? availableSeats;
  final CarInfo? car; 

  TripModel({
    required this.id,
    required this.from,
    required this.to,
    required this.driverId,
    required this.driverName,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.seats,
    this.rating = 4.5,
    this.category = "سيارة",
    this.carType = "عادية",
    this.availableSeats = 0,
    this.car,
  });
String get date =>
      DateFormat('yyyy-MM-dd').format(startTime);

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
      driverId: data['driverId'] ?? '',
      driverName: data['driverName'] ?? '',
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
      'driverId': driverId,
      'driverName': driverName,
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

 
  TripModel copyWith({
    String? id,
    String? from,
    String? to,
    String? driverId,
    String? driverName,
    DateTime? startTime,
    DateTime? endTime,
    num? price,
    int? seats,
    double? rating,
    String? category,
    String? carType,
    int? availableSeats,
    CarInfo? car,
  }) {
    return TripModel(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      price: price ?? this.price,
      seats: seats ?? this.seats,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      carType: carType ?? this.carType,
      availableSeats: availableSeats ?? this.availableSeats,
      car: car ?? this.car,
    );
  }
}

class CarInfo {
  final String id;
  final String carType;
  final int seats;

  CarInfo({
    required this.id,
    required this.carType,
    required this.seats,
  });

  factory CarInfo.fromDoc(Map<String, dynamic> data, String id) {
    return CarInfo(
      id: id,
      carType: data['carType'] ?? 'غير محدد',
      seats: data['seats'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carType': carType,
      'seats': seats,
    };
  }
}
