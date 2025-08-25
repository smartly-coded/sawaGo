class TripModel {
  final String from;
  final String to;
  final String? departureTime;
  final String ?arrivalTime;
  final String driverName;
  final double rating;
  final String ?price;
  

  TripModel({
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.driverName,
    required this.rating,
    required this.price,
  });
}
