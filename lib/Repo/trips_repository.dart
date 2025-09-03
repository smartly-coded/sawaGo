
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';

abstract class ITripsRepository {
  Future<List<TripModel>> fetchTrips();
}

class TripsRepository implements ITripsRepository {
  final FirebaseFirestore _db;
  TripsRepository(this._db);

  @override
  Future<List<TripModel>> fetchTrips() async {
    final snapshot = await _db.collection("rides").get();

    List<TripModel> trips = [];
    for (var doc in snapshot.docs) {
      final trip = TripModel.fromDoc(doc);

      if (trip.driverId.isNotEmpty) {
        final carSnap = await _db
            .collection("drivers")
            .doc(trip.driverId)
            .collection("cars")
            .limit(1)
            .get();

        if (carSnap.docs.isNotEmpty) {
          final carDoc = carSnap.docs.first;
          final car = CarInfo.fromDoc(carDoc.data(), carDoc.id);

          trips.add(trip.copyWith(
            seats: car.seats,
            carType: car.carType,
            car: car,
          ));
        } else {
          trips.add(trip);
        }
      } else {
        trips.add(trip);
      }
    }

    return trips; 
  }
}
