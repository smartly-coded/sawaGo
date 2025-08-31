// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// import 'package:sawago/Features/dashboard/model/trip_tracking_location/controller/driver_cubit.dart';
// import 'package:sawago/Features/dashboard/model/trip_tracking_location/controller/driver_state.dart';

// class MapTrackingPage extends StatefulWidget {
//   final String driverId;

//   const MapTrackingPage({super.key, required this.driverId});

//   @override
//   State<MapTrackingPage> createState() => _MapTrackingPageState();
// }

// class _MapTrackingPageState extends State<MapTrackingPage> {
//   final Location _location = Location();
//   LatLng? _userLocation;


//   final MapController _mapController = MapController();

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     final locationData = await _location.getLocation();
//     if (locationData.latitude != null && locationData.longitude != null) {
//       setState(() {
//         _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_userLocation == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return BlocProvider(
//       create: (_) =>
//           DriverCubit(driverId: widget.driverId, userLocation: _userLocation!),
//       child: Scaffold(
//         body: BlocListener<DriverCubit, DriverState>(
//           listener: (context, state) {
//             if (state is DriverUpdated) {
          
//               double currentZoom =
//                   _mapController.camera.zoom;
//               _mapController.move(state.driver.position, currentZoom);
//             }
//           },
//           child: BlocBuilder<DriverCubit, DriverState>(
//             builder: (context, state) {
//               return Stack(
//                 children: [
//                   FlutterMap(
//                     mapController: _mapController,
//                     options: MapOptions(
//                       initialCenter: _userLocation!,
//                       initialZoom: 14,
//                       interactionOptions: const InteractionOptions(
//                         flags: InteractiveFlag.none,
//                       ),
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                             'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=fQy5ZjdVia5wSz9YczlB',
//                         userAgentPackageName: 'com.example.app',
//                       ),
//                       if (state is DriverUpdated &&
//                           state.driver.position != _userLocation!)
//                         PolylineLayer(
//                           polylines: [
//                             Polyline(
//                               points: [state.driver.position, _userLocation!],
//                               strokeWidth: 4,
//                             ),
//                           ],
//                         ),
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             point: _userLocation!,
//                             width: 40,
//                             height: 40,
//                             child: const Icon(Icons.person_pin_circle,
//                                 size: 40, color: Colors.blue),
//                           ),
//                           if (state is DriverUpdated)
//                             Marker(
//                               point: state.driver.position,
//                               width: 40,
//                               height: 40,
//                               child: const Icon(Icons.local_taxi,
//                                   size: 40, color: Colors.orange),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   if (state is DriverUpdated)
//                     Positioned(
//                       top: 40,
//                       left: 20,
//                       right: 20,
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 28, 104, 23)
//                               .withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           "Time left: ${state.remainingMinutes.toStringAsFixed(1)} min",
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 18),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   if (state is DriverLoading)
//                     const Center(child: CircularProgressIndicator()),
//                   if (state is DriverError)
//                     Center(child: Text("Error: ${state.message}")),
//                 ],
//               );
//             },
//           ),
          
//         ),
//       ),
//     );
    
//   }
// }




