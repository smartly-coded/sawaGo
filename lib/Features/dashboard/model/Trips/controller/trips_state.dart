// import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';

// abstract class TripsState {}

// class TripsInitial extends TripsState {}

// class TripsLoading extends TripsState {}

// class TripsLoaded extends TripsState {
//   final List<TripModel> trips;
//   TripsLoaded(this.trips);
// }

// class TripsEmpty extends TripsState {}

// class TripsError extends TripsState {
//   final String message;
//   TripsError(this.message);
// }

// class TripsFilterChanged extends TripsState {
//   final bool isVisible;
//   TripsFilterChanged(this.isVisible);
// }


import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';

abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<TripModel> trips;
  final Map<String, int> categoryCounts; 

  TripsLoaded(this.trips, this.categoryCounts);
}

class TripsEmpty extends TripsState {}

class TripsError extends TripsState {
  final String message;
  TripsError(this.message);
}

class TripsFilterChanged extends TripsState {
  final bool isVisible;
  TripsFilterChanged(this.isVisible);
}
