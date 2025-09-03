


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_state.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';
import 'package:sawago/Repo/trips_repository.dart';

class TripsCubit extends Cubit<TripsState> {
  final ITripsRepository repo;
  TripsCubit(this.repo) : super(TripsInitial());

  bool isFilterVisible = false;
  String selectedCategory = "جميع الرحلات";

  List<TripModel> allTrips = [];
  List<TripModel> filteredTrips = [];
  Map<String, int> categoryCounts = {};

  Future<void> fetchTrips() async {
    emit(TripsLoading());
    try {
      allTrips = await repo.fetchTrips();

      if (allTrips.isEmpty) {
        emit(TripsEmpty());
      } else {
       
        _calculateCategoryCounts();

        filteredTrips = allTrips;
        emit(TripsLoaded(filteredTrips, categoryCounts));
      }
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }

  void toggleFilter() {
    isFilterVisible = !isFilterVisible;
    emit(TripsFilterChanged(isFilterVisible));
    emit(TripsLoaded(filteredTrips, categoryCounts));
  }

  void selectCategory(String category) {
    selectedCategory = category;

    if (category == "جميع الرحلات") {
      filteredTrips = allTrips;
    } else {
      filteredTrips =
          allTrips.where((trip) => trip.category == category).toList();
    }

    emit(TripsLoaded(filteredTrips, categoryCounts));
  }

  void _calculateCategoryCounts() {
    categoryCounts = {};

    for (final trip in allTrips) {
      categoryCounts[trip.category] =
          (categoryCounts[trip.category] ?? 0) + 1;
    }

    categoryCounts["جميع الرحلات"] = allTrips.length;
  }


    void searchTrips({
    required String from,
    required String to,
    required String date,
    required int passengers,
  }) {
    emit(TripsLoading());

    filteredTrips = allTrips.where((trip) {
      final matchesFrom = trip.from.contains(from);
      final matchesTo = trip.to.contains(to);

    
      final matchesDate = trip.date == date;

      final hasSeats = trip.availableSeats != null &&
          trip.availableSeats! >= passengers;

      return matchesFrom && matchesTo && matchesDate && hasSeats;
    }).toList();

    if (filteredTrips.isEmpty) {
      emit(TripsEmpty());
    } else {
      emit(TripsLoaded(filteredTrips, categoryCounts));
    }
  }
}
