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
    return snapshot.docs.map((doc) => TripModel.fromDoc(doc)).toList();
  }
}
