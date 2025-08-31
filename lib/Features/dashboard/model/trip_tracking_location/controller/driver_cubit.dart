// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:sawago/Features/dashboard/model/trip_tracking_location/model/driver_model.dart';
// import 'driver_state.dart';

// class DriverCubit extends Cubit<DriverState> {
//   final DatabaseReference _ref;
//   final LatLng userLocation;
//   StreamSubscription? _sub;
//   final Distance _distance = const Distance(); 

//   DriverCubit({required String driverId, required this.userLocation})
//       : _ref = FirebaseDatabase.instance.ref('drivers/$driverId'),
//         super(DriverInitial()) {
//     _listenToDriver();
//   }

//   void _listenToDriver() {
//     emit(DriverLoading());
//     _sub = _ref.onValue.listen((event) {
//       final data = event.snapshot.value;
//       if (data is Map) {
//         final driver = DriverModel.fromMap(event.snapshot.key!, data);

//         final meters = _distance(
//           LatLng(driver.lat, driver.lng),
//           userLocation,
//         );

//         const speed = 11; 
//         final minutes = (meters / speed) / 60;

//         emit(DriverUpdated(driver: driver, remainingMinutes: minutes));
//       }
//     }, onError: (e) {
//       emit(DriverError(e.toString()));
//     });
//   }

//   @override
//   Future<void> close() {
//     _sub?.cancel();
//     return super.close();
//   }
// }
